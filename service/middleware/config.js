const router = require("express").Router();
const jwt = require("jsonwebtoken");
const config = require("config");

const User = require("../models/users");

router.get("/", async (req, res) => {
  try {
    const { token } = req.query;

    if (token) {
      console.log(jwt);
      const verify = jwt.verify(token, config.get("secret_key"));

      if (verify) {
        const userId = verify.userId;

        const user = await User.findOne({ userId });

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

module.exports = router;
