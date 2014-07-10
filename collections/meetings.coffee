root = global ? window

root.Meetings = new Meteor.Collection "meetings",
  schema: new SimpleSchema
    title:
      type: String

Meteor.methods
  meetingsDelete: (id) ->
    Participations.remove(meeting_id: id)
    Meetings.remove(id)
