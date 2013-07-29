#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.10.5"
\paper {
   indent = #0
   printallheaders = ##t
   print-all-headers = ##t
   ragged-right = ##f
   ragged-bottom = ##t
}
\layout {
   \context { \Score
      \override MetronomeMark #'padding = #'5
   }
   \context { \Staff
      \override TimeSignature #'style = #'numbered
      \override StringNumber #'transparent = ##t
   }
   \context { \TabStaff
      \override TimeSignature #'style = #'numbered
      \override Stem #'transparent = ##t
      \override Beam #'transparent = ##t
      \override Tie  #'after-line-breaking = #tie::tab-clear-tied-fret-numbers
   }
   \context { \TabVoice
      \override Tie #'stencil = ##f
   }
   \context { \StaffGroup
      \consists "Instrument_name_engraver"
   }
}
deadNote = #(define-music-function (parser location note) (ly:music?)
   (set! (ly:music-property note 'tweaks)
      (acons 'stencil ly:note-head::print
         (acons 'glyph-name "2cross"
            (acons 'style 'special
               (ly:music-property note 'tweaks)))))
   note)

palmMute = #(define-music-function (parser location note) (ly:music?)
   (set! (ly:music-property note 'tweaks)
      (acons 'style 'do (ly:music-property note 'tweaks)))
   note)

TrackAVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=111
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 1/4
   \oneVoice
   r4 
   \time 4/4
   \repeat volta 99 {
      <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <cis'''\1>8 <b''\1>8 
      <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <dis''\3>8 <fis''\2>16 <g''\2>16 
      <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <cis'''\1>8 <b''\1>8 
      <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <gis''\2>8 <fis''\2>16 <dis''\3>8 <fis''\2>16 <g''\2>16 
      <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais''\4>16 <dis'''\3>16 <fis'''\2>16 <dis'''\3>16 <fis'''\2>16 <ais'''\1>16 <dis''''\1>16 <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 
      <gis'''\1>16 <e'''\2>16 <b''\3>16 <gis'''\1>16 <e'''\2>16 <b''\3>16 <gis''\4>16 <b''\3>16 <e'''\2>16 <b''\3>16 <e'''\2>16 <gis'''\1>16 <b'''\1>16 <gis'''\1>16 <e'''\2>16 <b''\3>16 
      <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais''\4>16 <dis'''\3>16 <fis'''\2>16 <dis'''\3>16 <fis'''\2>16 <ais'''\1>16 <dis''''\1>16 <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 
      <gis'''\1>16 <e'''\2>16 <b''\3>16 <gis'''\1>16 <e'''\2>16 <b''\3>16 <gis''\4>16 <b''\3>16 <e'''\2>16 <b''\3>16 <e'''\2>16 <gis'''\1>16 <b'''\1>16 <gis'''\1>16 <e'''\2>16 <b''\3>16 
      \times 2/3 {<ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais''\4>16 <dis'''\3>16 <fis'''\2>16 <b'''\1>16 <gis'''\2>16 <e'''\3>16 <b''\4>16 <e'''\3>16 <gis'''\2>16 <ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais''\4>16 <dis'''\3>16 <fis'''\2>16 <gis'''\1>16 <e'''\2>16 <cis'''\3>16 <gis''\4>16 <cis'''\3>16 <e'''\2>16 } 
      \times 2/3 {<ais'''\1>16 <fis'''\2>16 <dis'''\3>16 <ais''\4>16 <dis'''\3>16 <fis'''\2>16 <b'''\1>16 <gis'''\2>16 <e'''\3>16 <b''\4>16 <e'''\3>16 <gis'''\2>16 <cis''''\1>16 <ais'''\2>16 <fis'''\3>16 <cis'''\4>16 <fis'''\3>16 <ais'''\2>16 <b'''\1>16 <gis'''\2>16 <e'''\3>16 <b''\4>16 <e'''\3>16 <gis'''\2>16 } 
      <ais'''~\1>1 
      <ais'''\1>1 
   }
   \bar "|."
   \pageBreak
#})
TrackAVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackALyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackAStaff = \new Staff <<
   \context Voice = "TrackAVoiceAMusic" {
      \TrackAVoiceAMusic ##f
   }
   \context Voice = "TrackAVoiceBMusic" {
      \TrackAVoiceBMusic ##f
   }
>>
TrackATabStaff = \new TabStaff \with { stringTunings = #'( 16 11 7 2 -3 -8 ) } <<
   \context TabVoice = "TrackAVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic ##t
   }
   \context TabVoice = "TrackAVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceBMusic ##t
   }
>>
TrackAStaffGroup = \new StaffGroup <<
   \TrackAStaff
   \TrackATabStaff
>>
TrackBVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=111
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 1/4
   \oneVoice
   r4 
   \time 4/4
   \repeat volta 99 {
      <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <gis''\2>8 <fis''\2>8 
      <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <ais'\4>8 <cis''\3>16 <d''\3>16 
      <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <gis''\2>8 <fis''\2>8 
      <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <dis''\3>8 <cis''\3>16 <ais'\4>8 <cis''\3>16 <d''\3>16 
      <dis'''\2>16 <ais''\3>16 <fis''\4>16 <dis'''\2>16 <ais''\3>16 <fis''\4>16 <dis''\5>16 <fis''\4>16 <fis'''\2>16 <fis''\4>16 <ais''\3>16 <dis'''\2>16 <dis''''\1>16 <dis'''\2>16 <ais''\3>16 <fis''\4>16 
      <cis'''\2>16 <gis''\3>16 <e''\4>16 <cis'''\2>16 <gis''\3>16 <e''\4>16 <cis''\5>16 <e''\4>16 <gis''\3>16 <e''\4>16 <gis''\3>16 <cis'''\2>16 <e'''\1>16 <cis'''\2>16 <gis''\3>16 <e''\4>16 
      <dis'''\2>16 <ais''\3>16 <fis''\4>16 <dis'''\2>16 <ais''\3>16 <fis''\4>16 <dis''\5>16 <fis''\4>16 <fis'''\2>16 <fis''\4>16 <ais''\3>16 <dis'''\2>16 <dis''''\1>16 <dis'''\2>16 <ais''\3>16 <fis''\4>16 
      <cis'''\2>16 <gis''\3>16 <e''\4>16 <cis'''\2>16 <gis''\3>16 <e''\4>16 <cis''\5>16 <e''\4>16 <gis''\3>16 <e''\4>16 <gis''\3>16 <cis'''\2>16 <e'''\1>16 <cis'''\2>16 <gis''\3>16 <e''\4>16 
      \times 2/3 {<dis'''\1>16 <ais''\2>16 <fis''\3>16 <dis''\4>16 <fis''\3>16 <ais''\2>16 <e'''\1>16 <b''\2>16 <gis''\3>16 <e''\4>16 <gis''\3>16 <b''\2>16 <dis'''\1>16 <ais''\2>16 <fis''\3>16 <dis''\4>16 <fis''\3>16 <ais''\2>16 <cis'''\1>16 <gis''\2>16 <e''\3>16 <cis''\4>16 <e''\3>16 <gis''\2>16 } 
      \times 2/3 {<dis'''\1>16 <ais''\2>16 <fis''\3>16 <dis''\4>16 <fis''\3>16 <ais''\2>16 <e'''\1>16 <b''\2>16 <gis''\3>16 <e''\4>16 <gis''\3>16 <b''\2>16 <fis'''\1>16 <cis'''\2>16 <ais''\3>16 <fis''\4>16 <ais''\3>16 <cis'''\2>16 <e'''\1>16 <b''\2>16 <gis''\3>16 <e''\4>16 <gis''\3>16 <b''\2>16 } 
      <dis'''~\1>1 
      <dis'''\1>1 
   }
   \bar "|."
   \pageBreak
#})
TrackBVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackBLyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackBStaff = \new Staff <<
   \context Voice = "TrackBVoiceAMusic" {
      \TrackBVoiceAMusic ##f
   }
   \context Voice = "TrackBVoiceBMusic" {
      \TrackBVoiceBMusic ##f
   }
>>
TrackBTabStaff = \new TabStaff \with { stringTunings = #'( 16 11 7 2 -3 -8 ) } <<
   \context TabVoice = "TrackBVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackBVoiceAMusic ##t
   }
   \context TabVoice = "TrackBVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackBVoiceBMusic ##t
   }
>>
TrackBStaffGroup = \new StaffGroup <<
   \TrackBStaff
   \TrackBTabStaff
>>
TrackCVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=111
   \clef #(if $inTab "tab" "bass_8")
   \key c \major
   \time 1/4
   \oneVoice
   r4 
   \time 4/4
   \repeat volta 99 {
      <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <dis,,\5>8 <dis,,\5>16 <fis,,\4>16 <g,,\4>16 
      <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <dis,,\5>8 <dis,,\5>16 <fis,,\4>16 <g,,\4>16 
      <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <dis,,\5>8 <dis,,\5>16 <fis,,\4>16 <g,,\4>16 
      <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <gis,,\4>16 <dis,,\5>8 <dis,,\5>16 <fis,,\4>16 <g,,\4>16 
      <dis,,\5>4. <ais,,\4>8 <fis,\2>8 <fis,\2>16 <f,\2>16 <fis,\2>16 <dis,\3>8 <ais,,\4>16 
      <cis,,\5>8. <gis,,\4>8. <cis,\3>8 <e,\3>16 <dis,\3>16 <e,\3>16 <cis,\3>8 <e,,\4>16 <gis,,\4>16 <b,,\4>16 
      <dis,,\5>4. <ais,,\4>8 <fis,\2>8 <fis,\2>16 <f,\2>16 <fis,\2>16 <dis,\3>8 <ais,,\4>16 
      <cis,,\5>8. <gis,,\4>8. <cis,\3>8 <e,\3>16 <dis,\3>16 <e,\3>16 <cis,\3>8 <e,,\4>16 <gis,,\4>16 <b,,\4>16 
      <dis,\3>8\staccato <dis,,\5>8 <e,\3>8\staccato <e,,\5>8 <dis,\3>8\staccato <dis,,\5>8 <cis,\3>8\staccato <cis,,\5>8 
      <dis,\3>8\staccato <dis,,\5>8 <e,\3>8\staccato <e,,\5>8 <fis,\3>8\staccato <fis,,\5>8 <e,\3>8\staccato <e,,\5>8 
      <dis,,\5>8 <ais,,\4>16 <dis,\3>8 <cis,\3>16 <dis,\3>16 <a,,\3>16 <ais,,\3>8 <b,,\3>8 <c,\3>8 <cis,\3>8 
      <dis,\2>8 <e,\2>8 <f,\2>8 <fis,\2>8 <g,\2>8 <dis,,\5>16 <ais,,\4>8 <dis,\3>16 <cis,\3>8 
   }
   \bar "|."
   \pageBreak
#})
TrackCVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackCLyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackCStaff = \new Staff <<
   \context Voice = "TrackCVoiceAMusic" {
      \TrackCVoiceAMusic ##f
   }
   \context Voice = "TrackCVoiceBMusic" {
      \TrackCVoiceBMusic ##f
   }
>>
TrackCTabStaff = \new TabStaff \with { stringTunings = #'( -17 -22 -27 -32 -37 ) } <<
   \context TabVoice = "TrackCVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackCVoiceAMusic ##t
   }
   \context TabVoice = "TrackCVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackCVoiceBMusic ##t
   }
>>
TrackCStaffGroup = \new StaffGroup <<
   \TrackCStaff
   \TrackCTabStaff
>>
TrackDVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=111
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 1/4
   \oneVoice
   <d,\4>16 <c,\6>32 <c,\6>32 <a\1 cis\2 d,\4 >16 <c,\6>16 
   \time 4/4
   \repeat volta 99 {
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <c,\6>8 <cis\1 a\2 d,\5 >8 <c,\6>16 <c,\6>16 <cis\1 a\2 d,\5 >8 <c,\6>16 <c,\6>16 <cis\1 a\2 d,\5 >16 <c,\6>8 <c,\6>16 <cis\1 a\2 d,\5 >16 <c,\6>16 
      <c,\6>8 <cis\1 a\2 d,\5 >8 <c,\6>16 <c,\6>16 <cis\1 a\2 d,\5 >8 <c,\6>16 <c,\6>16 <cis\1 a\2 d,\5 >16 <c,\6>8 <c,\6>16 <cis\1 a\2 d,\5 >16 <c,\6>16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
      <fis,\3 c,\6 >16 <fis,\3>16 <fis,\3 d,\5 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3>16 <fis,\3 c,\6 >16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <ais,\3 c,\6 >16 <fis,\3>16 <fis,\3 c,\6 >16 <fis,\3 d,\5 >16 <fis,\3 c,\6 >16 
   }
   \bar "|."
   \pageBreak
#})
TrackDVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackDLyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackDStaff = \new Staff <<
   \context Voice = "TrackDVoiceAMusic" {
      \TrackDVoiceAMusic ##f
   }
   \context Voice = "TrackDVoiceBMusic" {
      \TrackDVoiceBMusic ##f
   }
>>
TrackDTabStaff = \new TabStaff \with { stringTunings = #'( -60 -60 -60 -60 -60 -60 ) } <<
   \context TabVoice = "TrackDVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackDVoiceAMusic ##t
   }
   \context TabVoice = "TrackDVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackDVoiceBMusic ##t
   }
>>
TrackDStaffGroup = \new StaffGroup <<
   \TrackDStaff
   \TrackDTabStaff
>>
TrackEVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=111
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 1/4
   \oneVoice
   r4 
   \time 4/4
   \repeat volta 99 {
      <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <dis\5>8 <fis\4>8 
      <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <dis\5>8 <fis\4>8 
      <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <dis\5>8 <fis\4>8 
      <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <gis\4>16 <dis\5>8 <fis\4>8 
      <dis\5>8. <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 
      <cis\5>8. <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>8 <cis\5>16 <cis\5>16 <cis\5>16 
      <dis\5>8. <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 
      <cis\5>8. <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>16 <cis\5>8 <cis\5>16 <cis\5>16 <cis\5>16 
      r8 <dis\5>8 r8 <e\5>8 r8 <dis\5>8 r8 <cis\5>8 
      r8 <dis\5>8 r8 <e\5>8 r8 <fis\5>8 r8 <e\5>8 
      <dis\5>8. <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>8. <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 
      <dis\5>8. <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 <dis\5>8. <dis\5>8 <dis\5>16 <dis\5>16 <dis\5>16 
   }
   \bar "|."
   \pageBreak
#})
TrackEVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackELyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackEStaff = \new Staff <<
   \context Voice = "TrackEVoiceAMusic" {
      \TrackEVoiceAMusic ##f
   }
   \context Voice = "TrackEVoiceBMusic" {
      \TrackEVoiceBMusic ##f
   }
>>
TrackETabStaff = \new TabStaff \with { stringTunings = #'( 4 -1 -5 -10 -15 -20 ) } <<
   \context TabVoice = "TrackEVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackEVoiceAMusic ##t
   }
   \context TabVoice = "TrackEVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackEVoiceBMusic ##t
   }
>>
TrackEStaffGroup = \new StaffGroup <<
   \TrackEStaff
   \TrackETabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Bike Chase" 
      composer = "" 
      instrument = "Keyboard 1" 
   }
}
\score {
   \TrackBStaffGroup
   \header {
      title = "Bike Chase" 
      composer = "" 
      instrument = "Keyboard 2" 
   }
}
\score {
   \TrackCStaffGroup
   \header {
      title = "Bike Chase" 
      composer = "" 
      instrument = "Bass" 
   }
}
\score {
   \TrackDStaffGroup
   \header {
      title = "Bike Chase" 
      composer = "" 
      instrument = "Percussion" 
   }
}
\score {
   \TrackEStaffGroup
   \header {
      title = "Bike Chase" 
      composer = "" 
      instrument = "Guitar" 
   }
}
