const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')

const Publication = require('../models/publications')
const generateRandomName = require('../scripts/generateRandomName')

router.post(
    '/publication',
    express.json(),
    async (req, res) => {
        const { token, image, description } = req.body
        const verifyToken = jwt.verify(token, 'auth')

        if (verifyToken) {

            const userId = verifyToken.userId

            await new Publication({
                userId,
                data: image,
                description: description || '',
                name: generateRandomName(50)
            }).save()

            res.status(201).send()

        } else {
            res.status(401).send({ message: 'Вы не авторизованы' })
        }
    })

module.exports = router