Meteor.publish "meetings", ->
  Meetings.find()

Meteor.publish "participations", ->
  Participations.find()

Meteor.publish "users", ->
  Meteor.users.find()
