root = global ? window

root.Participations = new Meteor.Collection "participations",
  schema: new SimpleSchema
    user_id:
      type: String
    meeting_id:
      type: String
    points:
      type: String
      optional: true
