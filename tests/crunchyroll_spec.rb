#! /usr/bin/env ruby
#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++
require 'crunchyroll'

describe Crunchyroll do
  it 'gets infos about narushit' do # just because shonen jump's shits have no end
    crunchy = Crunchyroll.find 'naruto'
    crunchy.should              be_kind_of(Hash)

    crunchy[:title].should start_with('Naruto Shippuden')
    crunchy[:day  ].should start_with('Thursday'        )
    crunchy[:left ].should   end_with('seconds'         )
  end

  it 'gets infos about oneshit' do
    crunchy = Crunchyroll.find 'one piece'
    crunchy.should              be_kind_of(Hash)

    crunchy[:title].should start_with('One Piece')
    crunchy[:day  ].should start_with('Saturday' )
    crunchy[:left ].should   end_with('seconds'  )
  end

  it "gets today's releases" do
    crunchy = Crunchyroll.today
    crunchy.should         be_kind_of(Array)
    crunchy.length.should  be >= 4
  end
end