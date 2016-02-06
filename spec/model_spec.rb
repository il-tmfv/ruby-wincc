Dir["./modules/*"].each {|file| require file}
Dir["./models/*" ].each {|file| require file}

describe Wincc::Model do
    before(:each) do
        Wincc::Model.clear_tags
    end
    
    it "should return 'TAG_BINARY_TAG'" do
        expect(Wincc::Model.tag_type(:bit)).to eq('TAG_BINARY_TAG')
    end
    
    it "should return 'TAG_SIGNED_8BIT_VALUE'" do
        expect(Wincc::Model.tag_type(:sbyte)).to eq('TAG_SIGNED_8BIT_VALUE')
    end
    
    it "should return 'TAG_UNSIGNED_8BIT_VALUE'" do
        expect(Wincc::Model.tag_type(:ubyte)).to eq('TAG_UNSIGNED_8BIT_VALUE')
    end
    
    it "should return 'TAG_SIGNED_16BIT_VALUE'" do
        expect(Wincc::Model.tag_type(:sint16)).to eq('TAG_SIGNED_16BIT_VALUE')
    end
    
    it "should return 'TAG_UNSIGNED_16BIT_VALUE'" do
        expect(Wincc::Model.tag_type(:uint16)).to eq('TAG_UNSIGNED_16BIT_VALUE')
    end
    
    it "should return 'TAG_SIGNED_32BIT_VALUE'" do
        expect(Wincc::Model.tag_type(:sint32)).to eq('TAG_SIGNED_32BIT_VALUE')
    end
    
    it "should return 'TAG_FLOATINGPOINT_NUMBER_32BIT_IEEE_754'" do
        expect(Wincc::Model.tag_type(:float32)).to eq('TAG_FLOATINGPOINT_NUMBER_32BIT_IEEE_754')
    end
    
    it "should return 'TAG_FLOATINGPOINT_NUMBER_64BIT_IEEE_754'" do
        expect(Wincc::Model.tag_type(:float64)).to eq('TAG_FLOATINGPOINT_NUMBER_64BIT_IEEE_754')
    end
    
    it "should return 'TAG_TEXT_TAG_8BIT_CHARACTER_SET'" do
        expect(Wincc::Model.tag_type(:text8)).to eq('TAG_TEXT_TAG_8BIT_CHARACTER_SET')
    end
    
    it "should return 'TAG_TEXT_TAG_16BIT_CHARACTER_SET'" do
        expect(Wincc::Model.tag_type(:text16)).to eq('TAG_TEXT_TAG_16BIT_CHARACTER_SET')
    end    
    
    it "should return 'TAG_TEXT_REFERENCE'" do
        expect(Wincc::Model.tag_type(:ref)).to eq('TAG_TEXT_REFERENCE')
    end    
    
    it "should raise ArgumentError" do
        expect{ Wincc::Model.tag_type(:blabla) }.to raise_error(ArgumentError)
    end
    
    ###############################################################################################
    
    it "should raise ArgumentError" do
        expect{ Wincc::Model.create() }.to raise_error(ArgumentError)
    end
    
    it "should raise ArgumentError" do
        expect{ Wincc::Model.create({name: "valve"}) }.to raise_error(ArgumentError)
    end
    
    it "should raise ArgumentError" do
        expect{ Wincc::Model.create({address: "valve"}) }.to raise_error(ArgumentError)
    end
    
    it "should not raise" do
        expect{ Wincc::Model.create({name: "valve", address: "db1"}) }.not_to raise_error
    end
    
    ###############################################################################################
    
    it "should raise ArgumentError" do
        expect{ 
            Wincc::Model.create_tag(name: '-value', type: :bit, connection: 'AS', address: '*,D1.0', group: 'externals') 
            Wincc::Model.create_tag(name: '-value', type: :bit, connection: 'AS', address: '*,D1.0', group: 'external')
        }.to raise_error(ArgumentError)
    end
    
    it "should not raise ArgumentError" do
        expect{ 
            Wincc::Model.create_tag(name: '-value', type: :bit, connection: 'AS', address: '*,D1.0', group: 'externals') 
            Wincc::Model.create_tag(name: '-label', type: :text8, group: 'internals')
        }.not_to raise_error
    end
    
    ###############################################################################################
    
    it "should return script" do
        expect(Wincc::Model.tag_start("valve", set_to: '125')).to eq("objHMIGO.GetTag \"valve\"\r\nobjHMIGO.TagStart \"125\"\r\nobjHMIGO.CommitTag\r\n")
    end
    
    it "should return script" do
        expect(Wincc::Model.tag_start("valve", set_to: 125)).to eq("objHMIGO.GetTag \"valve\"\r\nobjHMIGO.TagStart \"125\"\r\nobjHMIGO.CommitTag\r\n")
    end
    
    ###############################################################################################
    
    it "should return empty string" do
        expect(Wincc::Model.bracketize('')).to eq('')
    end
    
    it "should return string with brackets" do
        expect(Wincc::Model.bracketize('string')).to eq("\"string\"")
    end
end