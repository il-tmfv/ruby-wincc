# ruby-wincc
Rails-like library for generating VBA scripts for WinCC

# example

In `Valve.rb` you specify tags for the current model:

```ruby
#Valve.rb

class Valve < Wincc::Model
    create_tag name: '-value', type: :float32, address: '*,DD0', group: 'externals'
    create_tag name: '-label', type: :text8, group: 'internals'
    create_tag name: '-opened', type: :bit, address: '*,D1.1', group: 'externals'
    create_tag name: '-closed', type: :bit, address: '*,D1.2', group: 'externals'
    create_tag name: '-code', type: :text8, group: 'internals'
end
```
In `main.rb` you "create" object (e.g valves)

```ruby
#main.rb

begin
    puts Valve.create name: 'V1', address: 'DB25', connection: 'AS', start_value: { '-label' => 'Some label', '-code' => 'Some code' }
rescue 
    puts "Error! " + $!.inspect + " \n" + $!.backtrace.join('\n')
end
```

# TODO
* Saving to files
* Adding VBA script start and end parts
* Generator for models