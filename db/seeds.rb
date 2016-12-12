# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Message.destroy_all
Booking.destroy_all
Event.destroy_all
User.destroy_all

user1 = User.new(email: "alyssa.biot@gmail.com", password: "123456")
user1.first_name = "Alyssa"
user1.last_name = "Biot"
user1.save

user2 = User.new(email: "isabelle.charon@gmail.com", password: "123456")
user2.first_name = "Isabelle"
user2.last_name = "Bonnard"
user2.save

user3 = User.new(email: "cthivet93@gmail.com", password: "123456")
user3.first_name = "Clémence"
user3.last_name = "Thivet"
user3.save

user4 = User.new(email: "domitille.de.percin@gmail.com", password: "123456")
user4.first_name = "Domitille"
user4.last_name = "Chenut"
user4.save

user5 = User.new(email: "seb.lewagon@gmail.com", password: "123456")
user5.first_name = "Seb"
user5.last_name = "Saunier"
user5.save

user6 = User.new(email: "boris.lewagon@gmail.com", password: "123456")
user6.first_name = "Boris"
user6.last_name = "Papillard"
user6.save

user7 = User.new(email: "jerome.lewagon@gmail.com", password: "123456")
user7.first_name = "Jérôme"
user7.last_name = "Lewagon"
user7.save

user8 = User.new(email: "maxence.lewagon@gmail.com", password: "123456")
user8.first_name = "Maxence"
user8.last_name = "Lewagon"
user8.save

user9 = User.new(email: "mamoun.lewagon@gmail.com", password: "123456")
user9.first_name = "Mamoun"
user9.last_name = "Lewagon"
user9.save

user10 = User.new(email: "kevin.lewagon@gmail.com", password: "123456")
user10.first_name = "Kevin"
user10.last_name = "Lewagon"
user10.save

user11 = User.new(email: "edward.lewagon@gmail.com", password: "123456")
user11.first_name = "Edward"
user11.last_name = "Lewagon"
user11.save

user12 = User.new(email: "romain.lewagon@gmail.com", password: "123456")
user12.first_name = "Romain"
user12.last_name = "Papillard"
user12.save

event1 = Event.new(location:"16 villa gaudelet - 75011 Paris", price: 10)
event1.name = "Raclette de fin de Batch"
event1.description = "Venez nombreux pour clôturer le Batch #43 autour d'une raclette ! PS: si vous avez un appareil à raclette, apportez-le !"
event1.starts_at = DateTime.new(2017,12,16,19,00,00)
event1.ends_at = DateTime.new(2017,12,16,23,00,00)
event1.user = user7
event1.max_participants = 30
event1.notif_subscription = true
event1.notif_cancellation = true
event1.notif_message = true
event1.withdrawed = false
event1.save!

booking1 = Booking.new()
booking1.event = event1
booking1.user = user7
booking1.on_waiting_list = false
booking1.cancelled = false
booking1.cancellation_message = nil
booking1.save!

booking2 = Booking.new()
booking2.event = event1
booking2.user = user1
booking2.on_waiting_list = false
booking2.cancelled = false
booking2.cancellation_message = nil
booking2.save!

booking3 = Booking.new()
booking3.event = event1
booking3.user = user3
booking3.on_waiting_list = false
booking3.cancelled = false
booking3.cancellation_message = nil
booking3.save!

booking4 = Booking.new()
booking4.event = event1
booking4.user = user4
booking4.on_waiting_list = false
booking4.cancelled = false
booking4.cancellation_message = nil
booking4.save!

booking5 = Booking.new()
booking5.event = event1
booking5.user = user5
booking5.on_waiting_list = false
booking5.cancelled = false
booking5.cancellation_message = nil
booking5.save!

booking6 = Booking.new()
booking6.event = event1
booking6.user = user6
booking6.on_waiting_list = false
booking6.cancelled = false
booking6.cancellation_message = nil
booking6.save!

booking7 = Booking.new()
booking7.event = event1
booking7.user = user8
booking7.on_waiting_list = false
booking7.cancelled = false
booking7.cancellation_message = nil
booking7.save!

booking8 = Booking.new()
booking8.event = event1
booking8.user = user9
booking8.on_waiting_list = false
booking8.cancelled = false
booking8.cancellation_message = nil
booking8.save!

booking9 = Booking.new()
booking9.event = event1
booking9.user = user10
booking9.on_waiting_list = false
booking9.cancelled = false
booking9.cancellation_message = nil
booking9.save!

booking10 = Booking.new()
booking10.event = event1
booking10.user = user11
booking10.on_waiting_list = false
booking10.cancelled = false
booking10.cancellation_message = nil
booking10.save!

booking11 = Booking.new()
booking11.event = event1
booking11.user = user12
booking11.on_waiting_list = false
booking11.cancelled = false
booking11.cancellation_message = nil
booking11.save!

message1 = Message.new(content: "Au top !")
message1.user = user6
message1.event = event1
message1.save!

message2 = Message.new(content: "Tout pour du fromage fondu !")
message2.user = user3
message2.event = event1
message2.save!

message2 = Message.new(content: "Raclette Vegan Friendly, bien sûr ;)")
message2.user = user7
message2.event = event1
message2.save!

event2 = Event.new(location:"La Trinité-sur-Mer", price: 70)
event2.name = "WE Voile entre potes"
event2.description = "Du Tour de Houat à Belle-Ile, venez profiter de l'air marin entre amis le temps d'un weekend !"
event2.starts_at = DateTime.new(2017,05,25,10,00,00)
event2.ends_at = DateTime.new(2017,05,28,19,00,00)
event2.user = user2
event2.max_participants = 5
event2.notif_subscription = true
event2.notif_cancellation = true
event2.notif_message = true
event2.withdrawed = false
event2.save!

booking12 = Booking.new()
booking12.event = event2
booking12.user = user2
booking12.on_waiting_list = false
booking12.cancelled = false
booking12.cancellation_message = nil
booking12.save!

booking13 = Booking.new()
booking13.event = event2
booking13.user = user5
booking13.on_waiting_list = false
booking13.cancelled = false
booking13.cancellation_message = nil
booking13.save!

booking14 = Booking.new()
booking14.event = event2
booking14.user = user3
booking14.on_waiting_list = false
booking14.cancelled = false
booking14.cancellation_message = nil
booking14.save!

booking15 = Booking.new()
booking15.event = event2
booking15.user = user1
booking15.on_waiting_list = false
booking15.cancelled = true
booking15.cancellation_message = "Je ne pourrai finalement pas venir, je pars au Wagon Tokyo :)"
booking15.save!

event3 = Event.new(location:"16 villa gaudelet - 75011 Paris", price: 20)
event3.name = "Hackathon au Wagon - Team Mamoun"
event3.description = "Rejoignez mon équipe pour le Hackaton final du Batch #43 ! Pizzas et bières à volonté ;)"
event3.starts_at = DateTime.new(2017,12,10,10,00,00)
event3.ends_at = DateTime.new(2017,12,11,23,00,00)
event3.user = user9
event3.max_participants = 4
event3.notif_subscription = true
event3.notif_cancellation = true
event3.notif_message = true
event3.withdrawed = false
event3.save!

booking16 = Booking.new()
booking16.event = event3
booking16.user = user9
booking16.on_waiting_list = false
booking16.cancelled = false
booking16.cancellation_message = nil
booking16.save!

booking17 = Booking.new()
booking17.event = event3
booking17.user = user10
booking17.on_waiting_list = false
booking17.cancelled = false
booking17.cancellation_message = nil
booking17.save!

booking18 = Booking.new()
booking18.event = event3
booking18.user = user7
booking18.on_waiting_list = false
booking18.cancelled = false
booking18.cancellation_message = nil
booking18.save!

booking19 = Booking.new()
booking19.event = event3
booking19.user = user5
booking19.on_waiting_list = false
booking19.cancelled = false
booking19.cancellation_message = nil
booking19.save!

booking20 = Booking.new()
booking20.event = event3
booking20.user = user2
booking20.on_waiting_list = true
booking20.cancelled = false
booking20.cancellation_message = nil
booking20.save!
