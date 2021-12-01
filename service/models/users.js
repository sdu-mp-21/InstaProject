const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    userId: {
      type: Number,
      required: true,
    },
    login: {
      type: String,
      required: true,
      unique: true,
    },
    name: {
      type: String,
      required: true,
    },
    surname: {
      type: String,
      required: true,
    },
    site: {
      type: String,
      default: "",
    },
    password: {
      type: String,
      required: true,
    },
    phoneNumber: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      default: "",
    },
    registrationDate: {
      type: Date,
      default: Date.now(),
    },
    aboutMe: {
      type: String,
      default: "",
    },
    avatar: {
      type: String,
      default:
        "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg",
    },
    oldPasswords: {
      type: Array,
      default: [],
    },
    subscribers: {
      type: Array,
      default: [],
    },
    closeFriends: {
      type: Array,
      default: [],
    },
    gender: {
      type: String,
      default: "",
    },
    birthday: {
      type: String,
      default: "",
    },
  },
  {
    timestamps: true,
  }
);

userSchema.index({ "$**": "text" });

module.exports = mongoose.model("users", userSchema);
