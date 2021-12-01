const router = require("express").Router();
const jwt = require("jsonwebtoken");
const config = require("config");

const User = require("../models/users");

router.get("/", async (req, res) => {
  try {
    const { token } = req.query;

    if (token) {
      let verify = null;
      try {
        verify = jwt.verify(token, config.get("secret_key"));
      } catch (e) {}

      if (verify) {
        const userId = verify.userId;

        const user = await User.findOne(
          { userId },
          {
            userId: 1,
            name: 1,
            surname: 1,
            login: 1,
            site: 1,
            phoneNumber: 1,
            email: 1,
            aboutMe: 1,
            avatar: 1,
            gender: 1,
            birthday: 1,
          }
        );

        if (user) {
          res.status(200).send(user);
        } else {
          res.status(404).send();
        }
      } else {
        res.status(401).send();
      }
    } else {
      res.status(401).send();
    }
  } catch (e) {
    console.log(e);
    res.status(500).send();
  }
});

router.post("/change", async (req, res) => {
  try {
    const { token } = req.query;

    if (token) {
      let verify = null;
      try {
        verify = jwt.verify(token, config.get("secret_key"));
      } catch (tokenErr) {}

      if (verify) {
        const userId = verify.userId;

        const newConfig = req.body;

        if (newConfig.login) {
          if (!await checkLogin(newConfig.login)) {
            res.status(400).send();

            return;
          }
        }

        delete newConfig.userId;
        delete newConfig.password;
        delete newConfig.registrationDate;
        delete newConfig._id;

        await User.updateOne({ userId }, newConfig);

        res.status(200).send();
      } else {
        res.status(401).send();
      }
    } else {
      res.status(401).send({ message: "Token not found in query" });
    }
  } catch (e) {
    console.log(e);
    res.status(500).send();
  }
});

const checkLogin = async (login) => {
  const user = await User.findOne({ login });

  if (user) {
    return false;
  }

  return true;
};

module.exports = router;
