const express = require("express");
const router = express.Router();

router.use("/api/auth", require("../middleware/auth"));

router.use("/get", require("../middleware/get"));

router.use("/upload", require("../middleware/upload"));

router.use("/search", require("../middleware/search"));

router.use("/like", require("../middleware/like"));

router.use("/comment", require("../middleware/comment"));

router.use("/stories", require("../middleware/stories"));

router.use("/follow", require("../middleware/follow"));

router.use("/config", require("../middleware/config"));

module.exports = router;
