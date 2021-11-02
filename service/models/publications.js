const mongoose = require('mongoose')
const autoIncrement = require('mongoose-auto-increment')

const publicationSchema = new mongoose.Schema(
    {
        publicationId: {
            type: Number,
            default: 0
        },
        userId: {
            type: Number,
            required: true
        },
        likes: {
            type: Array,
            default: []
        },
        comments: {
            type: Array,
            default: []
        },
        desctiption: {
            type: String,
            default: ''
        },
        image: {
            data: {
                type: Buffer,
                required: true
            }
        }
    }, {
        timestamps: true
    }
)

autoIncrement.initialize(mongoose)
publicationSchema.plugin(autoIncrement.plugin, {
    model: 'publication',
    field: 'publicationId',
    startAt: 1,
    incrementBy: 1
})

module.exports = mongoose.model('publications', publicationSchema)