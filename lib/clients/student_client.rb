require 'rest_client'
require 'redis'
require 'yaml'
require Rails.root.join('lib/salva/site_config')
class StudentClient
  include Salva::SiteConfig

  def initialize(login)
    @site =Salva::SiteConfig.misc('schoolar_system_api')
    @url = "#{@site}/students.json?login=#{login}"
    @resource = RestClient::Resource.new @url
    @redis_enabled = false

    @redis_conf_path = Rails.root.join('config/resque.yml')
    if File.exists? @redis_conf_path
      redis_conf = YAML.load(File.open(@redis_conf_path)).symbolize_keys[Rails.env.to_sym]
      host, port = redis_conf.split(':')
      @redis = Redis.new(:host => host, :port => port)
      @key = login
      @redis_enabled = true
    end
  end

  def get_resource
    @resource.get {|response, request, result|
      response.code.to_i == 200 ? response : {students:[]}.to_s
    }
  end

  def get_hash
    @redis_enabled ? hash_from_redis : JSON.parse(get_resource).to_hash
  end

  def hash_from_redis
    if @redis.get(@key).nil?
      @redis.set(@key, get_resource)
      @redis.expire(@key, Date.today + 1.day)
    end
    JSON.parse(@redis.get(@key)).to_hash
  end

  def all
    get_hash['students']
  end
end
