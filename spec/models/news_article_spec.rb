require 'rails_helper'

# 



RSpec.describe NewsArticle, type: :model do

  describe "validate the title" do
    it ("requires a title") do
      nA = NewsArticle.new 

      nA.valid?

      expect(nA.errors.messages).to have_key(:title)
    end


    # This test kept failing because checking for uniqueness involves checking against everything in the database. But without .create, nothing yet was in the database to check against.

    # Also, the database worked on here is the amazon-test database.
    # At the end of every rspec, it's reset to a pristine state with no entries.

    it ("requires a unique title") do
      nA = NewsArticle.create title:"Coverage", description: "angle on event"
    
      nA2 = NewsArticle.new title:"coverage", description: "angle on event" 
  
      nA2.valid?

      expect(nA2.errors.messages).to have_key(:title)

    end
  end

  describe "validate the description" do
    it ("requires a description") do
      nA = NewsArticle.new title:"Catchy title"
      # nA.valid?

      expect(nA).to be_invalid
      
    end

  end

  describe "validate the published_at date" do
    it ("needs a published_at date/time after created_at") do
      nA = NewsArticle.create title:"whatever", description: "clever coverage" 
      
      nA.published_at = Time.now - 1000
      nA.save

      expect(nA.errors.messages).to have_key(:published_at)
    end
  end

  it "validates that the title gets titleized after save" do

  end

  describe "publish method" do
    it "sets published_at to now" do
      n = NewsArticle.new
      n.save
      n.publish

      expect(n.published_at.to_i).to eq(Time.zone.now.to_i)
      # the Time.zone.now call when we we call 
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
