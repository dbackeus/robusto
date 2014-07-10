root = global ? window

root.Meetings = new Meteor.Collection("meetings")

Meteor.methods
  meetingsDelete: (id) ->
    Participations.remove(meeting_id: id)
    Meetings.remove(id)
