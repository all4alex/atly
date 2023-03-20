const admin = require('firebase-admin')
const functions = require('firebase-functions')

admin.initializeApp()

const db = admin.firestore()

exports.changeLastMessage = functions.firestore
  .document('rooms/{roomId}/messages/{messageId}')
  .onWrite((change, context) => {
    const message = change.after.data()
    if (message) {
      return db.doc('rooms/' + context.params.roomId).update({
        lastMessages: [message],
      })
    } else {
      return null
    }
  })


  exports.changeMessageStatus = functions.firestore
  .document('rooms/{roomId}/messages/{messageId}')
  .onWrite((change) => {
    const message = change.after.data()
    if (message) {
      if (['delivered', 'seen', 'sent'].includes(message.status)) {
        return null
      } else {
        return change.after.ref.update({
          status: 'delivered',
        })
      }
    } else {
      return null
    }
  })