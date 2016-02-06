Dir["./modules/*"].each {|file| require file}
Dir["./models/*" ].each {|file| require file}

begin
    puts Valve.create name: 'V1', address: 'DB25', connection: 'AS', start_value: { '-label' => 'Some label', '-code' => 'Some code' }
rescue 
    puts "Error! " + $!.inspect + " \n" + $!.backtrace.join('\n')
end