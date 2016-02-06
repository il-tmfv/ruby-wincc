class Valve < Wincc::Model
    create_tag name: '-value', type: :float32, address: '*,DD0', group: 'externals'
    create_tag name: '-label', type: :text8, group: 'internals'
    create_tag name: '-opened', type: :bit, address: '*,D1.1', group: 'externals'
    create_tag name: '-closed', type: :bit, address: '*,D1.2', group: 'externals'
    create_tag name: '-code', type: :text8, group: 'internals'
end