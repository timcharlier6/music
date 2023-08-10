##TEMPO SETTINGS

use_bpm 40

##ARRAY

notes_voix = [:db6, :db5]
notes_violon1 = [:gb5, :ab5, :bb5, :db6, :db6, :eb6, :db6, :bb5, :bb5, :db6, :eb6, :gb6, :db6, :db6, :db6]
notes_violon2 = [:db5, :f5, :eb5, :gb5, :f5, :ab5, :gb5, :eb5, :db5, :f5, :ab5, :bb5, :gb5, :f5, :gb5]
notes_alto = [:bb4, :ab4, :gb4, :bb4, :bb4, :cb5, :bb4, :gb4, :gb4,:bb4, :cb5, :db5, :bb4, :ab4, :bb4]
notes_violoncelle1 = [[:bb3, :ab3], [:ab3, :gb3], [:gb3, :gb3], [:bb3, :bb3], [:db4, :cb4], [:cb4, :bb3], [:bb3, :ab3], [:gb3, :gb3], [:bb3,:bb3], [:db4, :cb4], [:cb4, :bb3], [:bb3, :ab3], [:gb3, :f3], [:f3, :f3], [:bb3,:bb3], [:bb3,:bb3], [:bb3,:bb3], [:bb3,:bb3], [:bb3,:bb3]]
notes_violoncelle2 = [[:gb2, :gb2], [:f2, :f2], [:eb2, :eb2], [:gb2, :gb2], [:bb2, :bb2], [:ab2, :ab2], [:gb2, :f2], [:eb2, :eb2], [:gb2, :gb2], [:bb2, :bb2], [:ab2, :ab2], [:gb2, :f2], [:eb2, :eb2], [:db2, :db2], [:gb2, :gb2],[:gb2, :gb2],[:gb2, :gb2],[:gb2, :gb2],[:gb2, :gb2]]
notes_piano = [[:gb1, :gb0], [:f1, :f0], [:eb1, :eb0], [:gb1, :gb0], [:bb1, :bb0], [:ab1, :ab0], [:gb1, :gb0], [:eb1, :eb0], [:gb1, :gb0], [:bb1, :bb0], [:ab1, :ab0], [:gb1, :gb0], [:eb1, :eb0], [:db1, :db0], [:gb1, :gb0],[:gb1, :gb0], [:gb1, :gb0], [:gb1, :gb0], [:gb1, :gb0]]


##FUNCTIONS

define :chanteur do |notes_voix|
  in_thread do 
    with_fx :vowel, mix: 0.5 do
      use_synth :organ_tonewheel
      15.times do
        sleep 2
        play notes_voix[0], amp: 0.7, attack: 0.1, decay: 0.7, sustain: 1, release: 0.5
        sleep 2
        play notes_voix[1], amp: 0.7, attack: 0, decay: 0.5, sustain: 2, release: 1
        sleep 2
      end
    end
  end
end


define :premier_violon do |notes_violon1|
  in_thread do 
    use_synth :supersaw
    notes_violon1.each do |note|
      play note, pan: 1, amp: 0.2, attack: 1, decay: 1, sustain: 2, release: 2, vibrato_rate: 8, vibrato_depth: 3
      sleep 6
    end
  end
end


define :second_violon do |notes_violon2|
  in_thread do 
    use_synth :supersaw
    notes_violon2.each do |note|
      play note, pan: -1, amp: 0.2, attack: 1, decay: 1, sustain: 2, release: 2, vibrato_rate: 8, vibrato_depth: 3
      sleep 6
    end
  end
end

define :alto do |notes_alto|
  in_thread do 
    sync :tick
    use_synth :supersaw
    notes_alto.each do |note|
      play note, pan: 0, amp: 0.2, attack: 1, decay: 1, sustain: 2, release: 2, vibrato_rate: 8, vibrato_depth: 3
      sleep 6
    end
  end
end

define :premier_violoncelle do |notes_violoncelle1|
  in_thread do 
    use_synth :pulse
    notes_violoncelle1.each do |note|
      4.times do
        play note[0], amp: 0.3, pan: -0.5, attack: 0.5, release: 0.5, vibrato_rate: 20, vibrato_depth: 3
        sleep 1
      end
      2.times do
        play note[1], amp: 0.3, pan: -0.5, attack: 0.5, release: 0.5
        sleep 1
      end
    end
  end
end

define :second_violoncelle do |notes_violoncelle2|
  in_thread do 
    use_synth :pulse
    notes_violoncelle2.each do |note|
      5.times do
        play note[0], amp: 0.3, pan: 0.5, attack: 0.5, release: 0.5, vibrato_rate: 20, vibrato_depth: 3
        sleep 1
      end
      play note[1], amp: 0.3, pan: 0.5, attack: 0.5, release: 0.5, vibrato_rate: 20, vibrato_depth: 3
      sleep 1
    end
  end
end

define :piano do |notes_piano|
  in_thread do 
    use_synth :piano
    notes_piano.each do |note|
      sleep 2
      play note, amp: 0.9, decay: 1, sustain: 1, release: 2
      sleep 4
    end
  end
end


##CALLING

with_fx :reverb, mix: 0.4, room: 1 do
  
  chanteur notes_voix
  
  premier_violon notes_violon1
  
  second_violon notes_violon2
  
  alto notes_alto
  
  premier_violoncelle notes_violoncelle1
  
  second_violoncelle notes_violoncelle2
  
  piano notes_piano
  
end

