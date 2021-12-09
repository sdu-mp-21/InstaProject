const bcrypt = require("bcrypt");
const randomNumber = require("random-number");
const router = require("express").Router();
const jwt = require("jsonwebtoken");
const config = require("../config");

const USERS = require("../models/users");

// /api/auth/check/token
router.post("/check/token", async (req, res) => {
  if (req.query.token) {
    try {
      const { token } = req.query;

      const verify = jwt.verify(token, config.secret_key);

      if (verify) {
        res.status(200).send({ isValid: true });
      } else {
        res.status(200).send({ isValid: false });
      }
    } catch (e) {
      res.sendStatus(500);
    }
  } else {
    res.sendStatus(400);
  }
});

// /api/auth/registration
router.post("/registration", async (req, res) => {
  try {
    if (
      req.query.phone &&
      req.query.name &&
      req.query.surname &&
      req.query.login &&
      req.query.password &&
      req.query.repeatPassword
    ) {
      const { phone, name, surname, login, password, repeatPassword } =
        req.query;

      if (password !== repeatPassword) {
        res.send({ status: 400, message: "Пароли не совпадают" });
      } else {
        if (!validateLogin(login)) {
          res.send({
            status: 400,
            message: "Логин не соответствует к требованиям",
          });
        } else if (!validatePassword(password, login)) {
          res.send({
            status: 400,
            message: "Пароль не соответствует к требованиям",
          });
        } else {
          const user = await USERS.findOne({ login });

          if (user) {
            res.send({
              status: 400,
              message: "Пользователь с таким логином уже существует",
            });
          } else {
            const hashPassword = await bcrypt.hash(password, 16);

            const candidate = new USERS({
              userId: await generateUserId(),
              name,
              surname,
              login,
              password: hashPassword,
              phoneNumber: clearPhone(phone),
            });

            const token = jwt.sign(
              { userId: candidate.userId },
              config.get("secret_key"),
              {
                expiresIn: "6h",
              }
            );

            await candidate.save();

            res.status(200).send({ token });
          }
        }
      }
    } else {
      res.sendStatus(400);
    }
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

// /api/auth/login
router.post("/login", async (req, res) => {
  try {
    if (req.query.login && req.query.password) {
      const { login, password } = req.query;

      const user = await USERS.findOne({ login });

      try {
        if (user) {
          if (await bcrypt.compare(password, user.password)) {
            const token = jwt.sign(
              { userId: user.userId },
              config.get("secret_key"),
              {
                expiresIn: "6h",
              }
            );

            res.send({ status: 200, token });
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } catch (er) {
        res.send({ status: 400, message: "Логин или пароль неправильно" });
      }
    } else {
      res.status(400).send();
    }
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

function clearPhone(phone) {
  if (phone[0] === "+") {
    phone = phone.replace("+7", "7");
  } else if (phone[0] === "8") {
    phone = "7" + phone.substring(1, phone.length);
  }

  return phone.replace(/ /g, "");
}

async function generateUserId() {
  const gen = randomNumber.generator({
    min: 1000000,
    max: 99999999999,
    integer: true,
  });

  while (true) {
    const id = gen();
    const user = await USERS.findOne({ userId: id });

    if (!user) {
      return id;
    }
  }
}

function validateLogin(login) {
  if (login.length < 5 || login.length > 30) {
    return false;
  }

  login = login
    .replace(/[0-9]/g, "")
    .replace(/[a-zA-Z]/g, "")
    .replace(/[._]/g, "");

  return login.length === 0;
}

function validatePassword(password, login) {
  return true;

  if (login.length < 8 || login.length > 16) {
    return false;
  }

  if (password.toLowerCase() === login.toLowerCase()) {
    return false;
  }

  let countLetter = 0;
  let countDigit = 0;
  let countUpperLetter = 0;
  let countLowerLetter = 0;
  for (let i = 0; i < password.length; i++) {
    if (new RegExp(/[a-z]/g).test(password[i])) {
      countLetter++;
      countLowerLetter++;
    }
    if (new RegExp(/[A-Z]/g).test(password[i])) {
      countLetter++;
      countUpperLetter++;
    }
    if (new RegExp(/[0-9]/g).test(password[i])) {
      countDigit++;
    }
  }

  return (
    countLetter >= 2 &&
    countDigit >= 1 &&
    countUpperLetter >= 1 &&
    countLowerLetter >= 1
  );
}

module.exports = router;
