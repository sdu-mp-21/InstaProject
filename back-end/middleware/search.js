const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const multer = require('multer')
const fs = require('fs')
const User = require('../models/users')
const Publication = require('../models/publications')

router.get('/', async (req, res) => {
    // const verifyToken = jwt.verify(req.query.token)
    const verifyToken = true

    if (verifyToken) {
        const result = await User.find({
            $or: [
                { login: { $regex: req.query.q } },
                { name: { $regex: req.query.q } },
                { surname: { $regex: req.query.q } },
                { aboutMe: { $regex: req.query.q } }
            ],
            userId: { $ne: verifyToken.userId }
        },
            { login: 1, name: 1, surname: 1, avatar: 1, userId: 1 }
        )

        res.send({ result })
    }
})

module.exports = router