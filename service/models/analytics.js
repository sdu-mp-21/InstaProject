const mongoose = require("mongoose");

const analyticSchema = new mongoose.Schema({
  todayDate: {
    type: Date,
    default: Date.now(),
  },
  newUsers: {
    type: Number,
    default: 0,
  },
  newPublications: {
    type: Number,
    default: 0,
  },
});

module.exports = mongoose.model("analytics", analyticSchema);
