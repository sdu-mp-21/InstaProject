const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const fs = require('fs')
const User = require('../models/users')
const Publication = require('../models/publications')

router.post(
    '/publication',
    express.json(),
    async (req, res) => {
        const { token, image } = req.body
        const verifyToken = jwt.verify(token, 'auth')

        if (verifyToken) {

            var myBuffer = new Buffer(image.length);
            for (var i = 0; i < image.length; i++) {
                myBuffer[i] = image[i];
            }

            const userId = verifyToken.userId

            const newPublication = await new Publication({
                userId
            }).save()

            const fileName = 'images/' + newPublication._id + '.png'

            await Publication.updateOne({ _id: newPublication._id }, { imageUrl: 'http://localhost:5000/get/images/' + newPublication._id + '.png' })

            fs.writeFile(fileName, myBuffer, function (err) {
                if (err) {
                    console.log(err);
                } else {
                    console.log("The file was saved!");
                }
            });

            const user = await User.findOne({ userId })
            const publications = user.publications
            publications.push({
                src: 'http://localhost:5000/get/images/' + newPublication._id + '.png'
            })

            await User.updateOne({ userId }, { publications })

        } else {
            res.status(401).send({ message: 'Вы не авторизованы' })
        }
    })

module.exports = router