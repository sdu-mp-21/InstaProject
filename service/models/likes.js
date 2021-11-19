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
    likeId: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

autoIncrement.initialize(mongoose);
publicationSchema.plugin(autoIncrement.plugin, {
  model: "like",
  field: "likeId",
  startAt: 1,
  incrementBy: 1,
});

module.exports = mongoose.model("like", publicationSchema);
