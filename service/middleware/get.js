const router = require("express").Router();
const jwt = require("jsonwebtoken");
const fs = require("fs");
const config = require("config");

const User = require("../models/users");
const Like = require("../models/likes");
const Comment = require("../models/comments");
const Publication = require("../models/publications");
const Subscription = require("../models/subscriptions");

router.get("/profile", async (req, res) => {
  try {
    const verify = jwt.verify(req.query.token, "auth");
    if (verify) {
      const user = await User.findOne({ userId: verify.userId });
      const publications = await Publication.find({
        userId: verify.userId,
        type: "publication",
      });
      const subscriptions = await Subscription.find({
        srcUserId: verify.userId,
      });
      const subscribers = await Subscription.find({
        destUserId: verify.userId,
      });
      const pubs = [];

      for (let publication of publications) {
        try {
          const publicationName = publication.name;
          var myBuffer = new Buffer(publication.data.length);
          for (var i = 0; i < publication.data.length; i++) {
            myBuffer[i] = publication.data[i];
          }

          if (!fs.existsSync(`./publications/${publicationName}.png`)) {
            fs.writeFileSync(`./publications/${publicationName}.png`, myBuffer);
          }

          pubs.push({
            src: `${config.get("service.url")}get/images/${
              publication.publicationId
            }`,
            publicationId: publication.publicationId,
          });
        } catch (e) {
          console.log(e);
        }
      }

      res.status(200).send({
        publications: pubs,
        userId: user.userId,
        login: user.login,
        name: user.name,
        surname: user.surname,
        site: user.site,
        phoneNumber: user.phoneNumber,
        email: user.email,
        aboutMe: user.aboutMe,
        avatar: user.avatar,
        subscriptions,
        subscribers,
      });
    } else {
      res.status(401).send({ message: "Вы не авторизованы" });
    }
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcwODczNzc3NzM3LCJpYXQiOjE2MzczMTAyNzMsImV4cCI6MTYzNzMzMTg3M30.jiaGzMSB9LkuPNKH62y4wW3-8ebfRhZRBPT1h30kNeU?id=70873777737
router.get("/another/profile", async (req, res) => {
  try {
    console.log(req.query.token);
    const verify = jwt.verify(req.query.token, "auth");
    if (verify) {
      if (req.query.id) {
        const userId = req.query.id;
        const user = await User.findOne({ userId });
        const publications = await Publication.find({
          userId,
          type: "publication",
        });
        const subscriptions = await Subscription.find({
          srcUserId: userId,
        });
        const subscribers = await Subscription.find({
          destUserId: userId,
        });
        const pubs = [];

        for (let publication of publications) {
          try {
            const publicationName = publication.name;
            var myBuffer = new Buffer(publication.data.length);
            for (var i = 0; i < publication.data.length; i++) {
              myBuffer[i] = publication.data[i];
            }

            if (!fs.existsSync(`./publications/${publicationName}.png`)) {
              fs.writeFileSync(
                `./publications/${publicationName}.png`,
                myBuffer
              );
            }

            pubs.push({
              src: `${config.get("service.url")}get/images/${
                publication.publicationId
              }`,
              publicationId: publication.publicationId,
            });
          } catch (e) {
            console.log(e);
          }
        }

        const isSubscribe = await Subscription.findOne({
          srcUserId: verify.userId,
        });

        res.status(200).send({
          publications: pubs,
          userId: user.userId,
          login: user.login,
          name: user.name,
          surname: user.surname,
          site: user.site,
          phoneNumber: user.phoneNumber,
          email: user.email,
          aboutMe: user.aboutMe,
          avatar: user.avatar,
          subscriptions,
          subscribers,
          isSubscribe: isSubscribe === null ? false : true,
        });
      } else {
        res.status(400).send();
      }
    } else {
      res.status(401).send({ message: "Вы не авторизованы" });
    }
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.get("/publication", async (req, res) => {
  const verify = jwt.verify(req.query.token, "auth");
  const { publicationId } = req.query;

  if (verify) {
    const publication = await Publication.findOne(
      { type: "publication", publicationId },
      {
        publicationId: 1,
        userId: 1,
        likes: 1,
        comments: 1,
        desctiption: 1,
      }
    );

    const likes = await Like.find({ publicationId });
    const isLiked = await Like.findOne({
      publicationId,
      userId: verify.userId,
    });
    const comments = await Comment.find({ publicationId });

    const user = await User.findOne({ userId: verify.userId });

    res.send({
      publicationId: publication.publicationId,
      userId: publication.userId,
      likes,
      comments,
      description: publication.desctiption || "",
      src:
        `${config.get("service.url")}get/images/` + publication.publicationId,
      avatar: user.avatar,
      login: user.login,
      isLiked: isLiked !== null ? true : false,
    });
  } else {
    res.status(401).send();
  }
});

router.get("/comments", async (req, res) => {
  try {
    if (req.query.token) {
      const verify = jwt.verify(req.query.token, "auth");
      const publicationId = req.query.id;
      if (verify) {
        const allComments = await Comment.find({ publicationId });
        let result = [];

        for (let comment of allComments) {
          const user = await User.findOne({ userId: comment.userId });

          result.push({
            publicationId,
            userId: user.userId,
            commentId: comment.commentId,
            text: comment.text,
            created_at: comment.created_at,
            avatar: user.avatar,
            login: user.login,
          });
        }

        res.send({ comments: result });
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

router.post("/comment", async (req, res) => {
  try {
    if (req.body.token) {
      const verify = jwt.verify(req.body.token, "auth");
      if (verify) {
        const { publicationId, text } = req.body;
        const userId = verify.userId;

        if (publicationId && text) {
          await new Comment({
            publicationId,
            userId,
            text,
          }).save();

          res.status(200).send();
        } else {
          res.status(400).send();
        }
      } else {
        res.status(401).send({ message: "Укажите токен" });
      }
    } else {
      res.status(401).send();
    }
  } catch (e) {
    console.log(e);

    res.status(500).send();
  }
});

router.post("/delete/comment", async (req, res) => {
  try {
    const { commentId } = req.body;

    if (commentId) {
      await Comment.deleteMany({ commentId });
    } else {
      res.status(400).send();
    }
  } catch (e) {
    console.log(e);

    res.status(500).send();
  }
});

router.get("/following", async (req, res) => {
  try {
    const verify = jwt.verify(req.query.token, "auth");
    if (verify) {
      const peopleIFollow = await Subscription.find({
        srcUserId: verify.userId,
      });
      const mongoQuery = [];
      for (let people of peopleIFollow) {
        mongoQuery.push({
          userId: people.destUserId,
        });
      }

      const followings = await User.find(
        { $or: mongoQuery },
        { userId: 1, avatar: 1, login: 1, name: 1, surname: 1 }
      );

      res.send({ followings });
    } else {
      res.status(401).send();
    }
  } catch (e) {
    console.log(e);
    res.status(500).send();
  }
});

router.get("/publications", async (req, res) => {
  try {
    const verify = jwt.verify(req.query.token, "auth");
    if (verify) {
      const peopleIFollow = await Subscription.find({
        srcUserId: verify.userId,
      });

      const mongoQuery = [];
      for (let people of peopleIFollow) {
        mongoQuery.push({
          userId: people.destUserId,
        });
      }
      //70873777737
      //72258897972
      //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcwODczNzc3NzM3LCJpYXQiOjE2MzcyMTI5MzAsImV4cCI6MTYzNzIzNDUzMH0.Lablhk-ZOP5DVsWynQZgxjx9M3YcrbYHvhZfhiz4eQk
      if (mongoQuery.length !== 0) {
        const publications = await Publication.find({ $or: mongoQuery });

        let result = [];
        for (let publication of publications) {
          const user = await User.findOne({ userId: publication.userId });
          const likes = await Like.find({
            publicationId: publication.publicationId,
          });
          const comments = await Comment.find({
            publicationId: publication.publicationId,
          });
          const isLiked = await Like.findOne({
            publicationId: publication.publicationId,
            userId: verify.userId,
          });

          result.push({
            publicationId: publication.publicationId,
            userId: publication.userId,
            likes,
            comments,
            description: publication.desctiption || "",
            src:
              `${config.get("service.url")}get/images/` +
              publication.publicationId,
            avatar: user.avatar,
            login: user.login,
            isLiked: isLiked !== null ? true : false,
          });
        }

        const user = await User.findOne(
          { userId: verify.userId },
          { login: 1, userId: 1, name: 1, surname: 1, avatar: 1 }
        );

        res.send({ publications: result, user });
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

router.get("/images/:publicationId", async (req, res) => {
  const { publicationId } = req.params;
  if (publicationId) {
    const publication = await Publication.findOne({
      publicationId: parseInt(publicationId),
    });

    if (publication) {
      fs.writeFile(
        `./publications/${publication.name}.png`,
        publication.data,
        () => {
          res.download(`./publications/${publication.name}.png`);
        }
      );
    } else {
      res.status(404).send();
    }
  } else {
    res.status(400).send();
  }
});

module.exports = router;
