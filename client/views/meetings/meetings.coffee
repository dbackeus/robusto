Template.meetingsIndex.helpers
  meetings: ->
    Meetings.find()

Template.meetingsIndex.events
  "submit form": (e) ->
    e.preventDefault()
    title = $("[name=meeting-title]").val()
    return alert("title plz!") if title.length == 0
    Meetings.insert title: title
    $("#meeting-title").val("")

  "click .delete-meeting": (e) ->
    Meetings.remove @_id

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

  "click [data-points]": (e) ->
    $link = $(e.target)
    points = $link.data("points")
    meetingId = $link.closest("[data-id]").data("id")
    participationId = Participations.findOne(meeting_id: meetingId, user_id: Meteor.userId())._id
    Participations.update(participationId, $set: {points: points})

  "click #leave": (e) ->
    participationId = Participations.findOne(meeting_id: @_id, user_id: Meteor.userId())._id
    Participations.remove(participationId)

Template.participation.helpers
  name: ->
    user = Meteor.users.findOne(@user_id)
    if user
      user.profile.name
    else
      ""

  points: ->
    participations = Participations.find(meeting_id: @meeting_id).fetch()
    everyoneVoted = _.all(participations, (participation) -> participation.points?)

    if @points?
      if everyoneVoted
        @points
      else
        "voted"
    else
      "pending"

