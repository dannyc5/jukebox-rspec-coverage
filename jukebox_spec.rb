require 'simplecov'
SimpleCov.start
require 'json'
require 'rspec'

require_relative 'jukebox'
require_relative 'song'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

# use this song data for your tests
songs = [
 "The Phoenix - 1901",
 "Tokyo Police Club - Wait Up",
 "Sufjan Stevens - Too Much",
 "The Naked and the Famous - Young Blood",
 "(Far From) Home - Tiga",
 "The Cults - Abducted",
 "The Phoenix - Consolation Prizes"
]

describe Song do
  it "should be able to initialize a new song and set name" do
    song = Song.new("newsong")
    song.name.should eq("newsong")
  end
end

describe Jukebox do
  before :each do
    @jukebox = Jukebox.new(songs)
  end

  it "should be able to initialize a new jukebox with an array of songs" do
    @jukebox.songs.should eq([
       "The Phoenix - 1901",
       "Tokyo Police Club - Wait Up",
       "Sufjan Stevens - Too Much",
       "The Naked and the Famous - Young Blood",
       "(Far From) Home - Tiga",
       "The Cults - Abducted",
       "The Phoenix - Consolation Prizes"
      ])
  end

  describe "#on?" do
    it "should return the value of @on?" do
      @jukebox.on?.should eq(true)
    end
  end

  describe "#help" do
    it "should return the help message" do
      @jukebox.help.should eq("Please select help, list, exit, or play.")
    end
  end

  describe "#command" do
    it "should allow the list command and respond by executing list" do
      @jukebox.command("list").should eq("1. The Phoenix - 1901\n2. Tokyo Police Club - Wait Up\n3. Sufjan Stevens - Too Much\n4. The Naked and the Famous - Young Blood\n5. (Far From) Home - Tiga\n6. The Cults - Abducted\n7. The Phoenix - Consolation Prizes\n")
    end

    it "should allow the play command and respond by playing a given song" do
      @jukebox.command("play song").should eq("now playing song")
    end

    it "should allow the exit and help commands" do
      @jukebox.command("help").should eq("Please select help, list, exit, or play.")
      @jukebox.command("exit").should eq("Goodbye, thanks for listening!")
    end

    it "should not allow other commands besides play, exit, list and help" do
      @jukebox.command("asdf").should eq("invalid command")
    end

  end

  describe "#exit" do
    it "should turn @on? to false" do
      @jukebox.exit
      @jukebox.on?.should eq(false)
    end

    it "should return the exit message" do
      @jukebox.exit.should eq("Goodbye, thanks for listening!")
    end

  end

  describe "#list" do
    it "should list all songs" do
      @jukebox.list.should eq(
      "1. The Phoenix - 1901\n2. Tokyo Police Club - Wait Up\n3. Sufjan Stevens - Too Much\n4. The Naked and the Famous - Young Blood\n5. (Far From) Home - Tiga\n6. The Cults - Abducted\n7. The Phoenix - Consolation Prizes\n")
    end
  end

  describe "#play" do
    it "should play the song passed in the parameter" do
      @jukebox.play("song").should eq("now playing song")
    end
  end

end
