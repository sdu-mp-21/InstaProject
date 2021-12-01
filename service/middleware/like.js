const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const config = require("config");

const Publication = require("../models/publications");
const Like = require("../models/likes");
const User = require("../models/users");

router.post("/", async (req, res) => {
  try {
    const verifyToken = jwt.verify(req.query.token, config.get("secret_key"));

    if (verifyToken) {
      const { publicationId } = req.body;
      const userId = verifyToken.userId;

      const publication = await Publication.findOne({ publicationId });

      if (publication) {
        const like = await Like.findOne({ publicationId, userId });

        if (!like) {
          await new Like({
            userId,
            publicationId,
          }).save();
        } else {
          await Like.deleteOne({ likeId: like.likeId });
        }

        res.status(200).send();
      } else {
        res.status(400).send();
      }
    } else {
      res.status(401).send();
    }
  } catch (e) {
    console.log(e);
    res.status(500).send();
  }
});

router.get("/", async (req, res) => {
  try {
    // const verifyToken = jwt.verify(req.query.token, 'auth')
    const verifyToken = true;

    if (verifyToken) {
      const { publicationId } = req.query;

      const likes = await Like.find({ publicationId });

      let likesList = [];
      for (let like of likes) {
        likesList.push({ userId: like.userId });
      }

      if (likes.length > 0) {
        const users = await User.find(
          {
            $or: likesList,
          },
          {
            userId: 1,
            login: 1,
            name: 1,
            surname: 1,
            avatar: 1,
          }
        );

        res.send(users);
      } else {
        res.send([]);
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
