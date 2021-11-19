const mongoose = require("mongoose");

const subscriptionSchema = new mongoose.Schema(
  {
    srcUserId: {
      type: Number,
      required: true,
    },
    destUserId: {
      type: Number,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("subscription", subscriptionSchema);
