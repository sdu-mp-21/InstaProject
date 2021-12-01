const router = require("express").Router();
const jwt = require("jsonwebtoken");
const config = require("config");

const Subscription = require("../models/subscriptions");

router.post("/", async (req, res) => {
  try {
    const { id, token } = req.body;

    if (token) {
      const verify = jwt.verify(token, config.get("secret_key"));

      if (verify) {
        if (id) {
          const userId = verify.userId;
          if (id !== userId) {
            const subscription = await Subscription.findOne({
              srcUserId: userId,
              destUserId: id,
            });

            let isSubscribe = false;

            if (subscription) {
              await Subscription.deleteMany({
                srcUserId: userId,
                destUserId: id,
              });
            } else {
              await new Subscription({
                srcUserId: userId,
                destUserId: id,
              }).save();

              isSubscribe = true;
            }

            res.status(200).send({ isSubscribe });
          } else {
            res.status(400).send();
          }
        } else {
          res.status(400).send();
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

router.post("/check", async (req, res) => {
  try {
    const { id, token } = req.body;

    if (token) {
      const verify = jwt.verify(token, config.get("secret_key"));

      if (verify) {
        if (id) {
          const userId = verify.userId;

          const subscription = await Subscription.findOne({
            srcUserId: userId,
            destUserId: id,
          });

          res
            .status(200)
            .send({ isSubscribe: subscription === null ? false : true });
        } else {
          res.status(400).send();
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
