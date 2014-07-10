Template.meetingsIndex.helpers
  meetings: ->
    Meetings.find()

Template.meetingsIndex.events
  "click .delete-meeting": (e) ->
    Meteor.call "meetingsDelete", @_id

Template.meetingsShow.helpers
  participations: ->
    Participations.find({meeting_id: @_id})

  participating: ->
    Participations.findOne({meeting_id: @_id, user_id: Meteor.userId()})

  fibonacci: ->
    [0,1,2,3,5,8,13,"?"]

Template.meetingsShow.events
  "click #join": (e) ->
    Participations.insert({meeting_id: @_id, user_id: Meteor.userId()})

  "click #reset": (e) ->
    Participations.find(meeting_id: @_id).forEach (participation) ->
      Participations.update(participation._id, $set: {points: null})

  "click .btn-vote": (e, template) ->
    points = $(e.target).html()
    meetingId = template.data._id
    participationId = Participations.findOne(meeting_id: meetingId, user_id: Meteor.userId())._id
    Participations.update(participationId, $set: {points: points})

  "click #leave": (e) ->
    participationId = Participations.findOne(meeting_id: @_id, user_id: Meteor.userId())._id
    Participations.remove(participationId)

Template.participation.helpers
  flipped: ->
    participations = Participations.find({meeting_id: @meeting_id}).fetch()
    ownParticipationWithVote = @points? && @user_id == Meteor.userId()
    everyoneVoted = _.all(participations, (participation) -> participation.points?)
    "flipped" unless ownParticipationWithVote || everyoneVoted

  name: ->
    user = Meteor.users.findOne(@user_id)
    user.profile.name if user

  state: ->
    if @points?
      "Voted"
    else
      "Pending"

  avatar: ->
    user = Meteor.users.findOne(@user_id)
    user.services.google.picture
