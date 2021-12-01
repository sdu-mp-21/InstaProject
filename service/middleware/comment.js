const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const Comment = require("../models/comments");
const Publication = require("../models/publications");
const config = require("config");

router.post("/", async (req, res) => {
  const verifyToken = jwt.verify(req.query.token, config.get("secret_key"));

  if (verifyToken) {
    const { publicationId, text } = req.body;
    const userId = verifyToken.userId;

    if (text) {
      const publication = await Publication.findOne({ publicationId });

      if (publication) {
        await new Comment({
          publicationId,
          userId,
          text,
        }).save();

        res.status(200).send();
      } else {
        res.send(400).send();
      }
    } else {
      res.send(400).send();
    }
  } else {
    res.status(401).send();
  }
});

router.get("/", async (req, res) => {
  const verifyToken = jwt.verify(req.query.token, config.get("secret_key"));

  if (verifyToken) {
    const { publicationId } = req.body;

    const comments = await Comment.find({ publicationId });

    res.send(comments);
  } else {
    res.status(401).send();
  }
});

module.exports = router;
