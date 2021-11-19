const mongoose = require("mongoose");
const autoIncrement = require("mongoose-auto-increment");

const publicationSchema = new mongoose.Schema(
  {
    publicationId: {
      type: Number,
      default: 0,
    },
    userId: {
      type: Number,
      required: true,
    },
    likes: {
      type: Array,
      default: [],
    },
    comments: {
      type: Array,
      default: [],
    },
    desctiption: {
      type: String,
      default: "",
    },
    data: {
      type: Buffer,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      default: "publication",
    },
  },
  {
    timestamps: true,
  }
);

autoIncrement.initialize(mongoose);
publicationSchema.plugin(autoIncrement.plugin, {
  model: "publication",
  field: "publicationId",
  startAt: 1,
  incrementBy: 1,
});

module.exports = mongoose.model("publication", publicationSchema);
