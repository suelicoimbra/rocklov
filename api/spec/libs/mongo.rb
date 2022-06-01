require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :mongoDB, :users, :equipos

  def initialize
    @mongoDB = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = mongoDB[:users]
    @equipos = mongoDB[:equipos]
  end

  def drop_danger
    mongoDB.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(name, user_id)
    #Convertendo o string do Usuário ID em um objecto do tipo ObjectID
    obj_id = BSON::ObjectId.from_string(user_id)

    @equipos.delete_many({ name: name, user: obj_id })
  end

  def get_mongo_id
    return BSON::ObjectId.new
  end
end
