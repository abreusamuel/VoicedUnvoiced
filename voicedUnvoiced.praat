#Adaptação de: MURRAY, Elizabeth S. Heller; CHAO, Andie; COLLETTI, Lauren. A practical guide to calculating cepstral peak prominence in Praat. Journal of Voice, 2022.

info$ = Info
nome$ = extractWord$(info$, "Object name: ")
pitchSet = noprogress To Pitch (cc)... 0 70 15 "no" 0.03 0.45 0.01 0.35 0.14 600
median_f0 = Get quantile... 0 0 0.5 Hertz
median_period = 1/median_f0

selectObject: "Sound " + nome$
plus pitchSet
intervalos = To PointProcess (cc)
select pitchSet
Remove
select intervalos
txtVUV = To TextGrid (vuv)... 0.02 median_period
select intervalos
Remove

selectObject: "Sound " + nome$
plus txtVUV
Extract intervals where: 1, "no", "is equal to", "V"
onlyVoice = Concatenate
selectObject: "Sound " + nome$
original = Copy... original
select all
minus onlyVoice 
minus original
Remove

select onlyVoice
cepstrograma = noprogress To PowerCepstrogram: 60, 0.002, 5000, 50
select cepstrograma
tabelaCPPS = To Table (cepstral peak prominences): "no", "yes", 6, 3, "yes", 3, 60, 330, 0.05, "parabolic", 0.001, 0, "Straight", "Robust"
medianaCPPS = Get quantile: "quefrency(s)", 0.5

select onlyVoice
pitchSet2 = noprogress To Pitch (cc)... 0 70 15 "no" 0.03 0.45 0.01 0.35 0.14 600

select onlyVoice
plus pitchSet2

intervalos2 = To PointProcess (cc)
select pitchSet2
Remove
select intervalos2
txtVUV2 = To TextGrid (vuv)... 0.02 medianaCPPS
select intervalos2
Remove

select onlyVoice
plus txtVUV2
Extract intervals where: 1, "no", "is equal to", "V"
onlyVoice2 = Concatenate
select all
minus onlyVoice2
minus original
Remove
select onlyVoice2
Rename: nome$ + "_Vozeado"
select original
Rename: nome$