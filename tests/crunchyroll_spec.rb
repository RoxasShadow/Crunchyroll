#! /usr/bin/env ruby
##
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
##
require 'crunchyroll'

describe Crunchyroll do
  it 'gets infos about Naruto' do
    crunchy = Crunchyroll.find 'naruto'
    expect(crunchy).to be_kind_of(Hash)

    expect(crunchy[:title]).to start_with('Naruto')
    expect(crunchy[:left ]).to   end_with('seconds')
  end

  it 'cannot find non-simulcasted yet series' do
    crunchy = Crunchyroll.find 'pupa'
    expect(crunchy).to be_falsy
  end

  it "gets today's releases" do
    crunchy = Crunchyroll.today

    expect(crunchy).to be_kind_of(Array)
    expect(crunchy.first).to be_kind_of(Hash)
    expect(crunchy.first[:day]).to eq(Time.now.strftime('%A'))
  end
end
