const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    userId: {
        type: Number,
        required: true
    },
    login: {
        type: String,
        required: true,
        unique: true
    },
    name: {
        type: String,
        required: true
    },
    surname: {
        type: String,
        required: true
    },
    site: {
        type: String,
        default: ''
    },
    password: {
        type: String,
        required: true
    },
    phoneNumber: {
        type: String,
        required: true
    },
    email: {
        type: String,
        default: ''
    },
    registrationDate: {
        type: Date,
        default: Date.now()
    },
    aboutMe: {
        type: String,
        default: ''
    },
    avatar: {
        type: String,
        default: 'https://www.meme-arsenal.com/memes/fefac21eda463aa9a307c7cfdbea1bee.jpg'
    },
    publications: {
        type: Array,
        default: []
    },
    oldPasswords: {
        type: Array,
        default: []
    },
    subscribers: {
        type: Array,
        default: []
    },
    subscriptions: {
        type: Array,
        default: []
    },
    closeFriends: {
        type: Array,
        default: []
    },
    gender: {
        type: String,
        default: ''
    },
    birthday: {
        type: String,
        default: ''
    }
})

userSchema.index({'$**': 'text'})

module.exports = mongoose.model('users', userSchema)