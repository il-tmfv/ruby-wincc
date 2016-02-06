Dir["./modules/*"].each {|file| require file}

module Wincc
    class Model
        extend WinccTagType
        
        #array of tags for current model
        @@tags = []
        
        def self.clear_tags
            @@tags = []
        end
        
        def initialize 
            
        end
        
        #method for creating new object
        def self.create(obj_params)
            raise ArgumentError, "Missing object name", caller unless obj_params.has_key?(:name)
            raise ArgumentError, "Missing object address", caller unless obj_params.has_key?(:address)
            obj_params[:connection] ||= ''
            script = ''
            @@tags.each { |tag| 
                address = obj_params[:address] == '' ? 
                        '' : 
                        tag[:address].gsub(/\*/, obj_params[:address])
                full_tagname = obj_params[:name] + tag[:name]
                connection = address == '' ? '' : obj_params[:connection]
                script += "objHMIGO.CreateTag #{bracketize(full_tagname)}, #{tag_type(tag[:type])}, #{bracketize(connection)}, #{bracketize(address)}, #{bracketize(tag[:group])}\r\n"
                
                #handling start_value hash
                if obj_params.has_key? :start_value
                    if obj_params[:start_value].has_key? tag[:name]
                        script += tag_start(full_tagname, set_to: obj_params[:start_value][tag[:name]])
                    end
                end
            }
            return script
        end
        
        private #####################################################################
        
        #method for putting brackets around non-zero-length string
        def self.bracketize(str)
            str = str.to_s unless str.is_a? String
            if str.length == 0
                str
            else
                "\"" + str + "\""
            end
        end
        
        def self.tag_start(tag_name, value = {set_to: '0'})
            script =  "objHMIGO.GetTag #{bracketize(tag_name)}\r\n"
            script += "objHMIGO.TagStart #{bracketize(value[:set_to])}\r\n"
            script += "objHMIGO.CommitTag\r\n"
        end
            
        #method for creating tag for model
        def self.create_tag(tag_params)
            default_tag_params = { name: '-value', 
                                   type: :bit, 
                                   address: '', 
                                   group: 'default_group' }
            
            tag_params.keys.each { |key|
                default_tag_params[key] = tag_params[key] if tag_params.has_key?(key)    
            }
            check_if_already_added default_tag_params    
            @@tags << default_tag_params
        end
        
        #method to prevent adding duplicate tag in model
        def self.check_if_already_added(next_tag)
            @@tags.each { |tag|
                raise ArgumentError, "Tag #{next_tag[:name]} already in model", caller if tag[:name] == next_tag[:name]
            } 
        end        
    end
end