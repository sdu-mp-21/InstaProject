const mongoose = require("mongoose");
const autoIncrement = require("mongoose-auto-increment");

const publicationSchema = new mongoose.Schema(
  {
    publicationId: {
      type: Number,
      required: true,
    },
    userId: {
      type: Number,
      required: true,
    },
    commentId: {
      type: Number,
      default: 0,
    },
    text: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

autoIncrement.initialize(mongoose);
publicationSchema.plugin(autoIncrement.plugin, {
  model: "comment",
  field: "commentId",
  startAt: 1,
  incrementBy: 1,
});

module.exports = mongoose.model("comment", publicationSchema);
