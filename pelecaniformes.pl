order(pelecaniformes).

family(pelecanidae).
family(ardeidae).
family(threskiornithidae).

genus(pelecanus).
genus(botaurus).
genus(ixobrychus).
genus(ardea).
genus(egretta).
genus(bubulcus).
genus(butorides).
genus(nycticorax).
genus(nyctanassa).
genus(eudocimus).
genus(plegadis).
genus(platalea).

species(erythrorhynchos).
species(occidentalis).
species(lentiginosus).
species(exilis).
species(herodias).
species(alba).
species(thula).
species(caerulea).
species(tricolor).
species(rufescens).
species(ibis).
species(virescens).
species(nycticorax).
species(violacea).
species(albus).
species(falcinellus).
species(chihi).
species(ajaja).

hasParent(pelecanidae,pelecaniformes).
hasParent(ardeidae,pelecaniformes).
hasParent(threskiornithidae,pelecaniformes).

hasParent(pelecanus,pelecanidae).

hasParent(botaurus,ardeidae).
hasParent(ixobrychus,ardeidae).
hasParent(ardea,ardeidae).
hasParent(egretta,ardeidae).
hasParent(bubulcus,ardeidae).
hasParent(butorides,ardeidae).
hasParent(nycticorax,ardeidae).
hasParent(nyctanassa,ardeidae).

hasParent(eudocimus,threskiornithidae).
hasParent(plegadis,threskiornithidae).
hasParent(platalea,threskiornithidae).

hasParent(erythrorhynchos,pelecanus).
hasParent(occidentalis,pelecanus).
hasParent(lentiginosus,botaurus).
hasParent(exilis,ixobrychus).
hasParent(herodias,ardea).
hasParent(alba,ardea).
hasParent(thula,egretta).
hasParent(caerulea,egretta).
hasParent(tricolor,egretta).
hasParent(rufescens,egretta).
hasParent(ibis,bubulcus).
hasParent(virescens,butorides).
hasParent(nycticorax,nycticorax).
hasParent(violacea,nyctanassa).
hasParent(albus,eudocimus).
hasParent(falcinellus,plegadis).
hasParent(chihi,plegadis).
hasParent(ajaja,platalea). 

hasParent2(A,B) :- hasCompoundName(G,S,A) , genus(B), hasParent(S,B).
hasParent2(A,B) :- genus(A) , family(B), hasParent(A,B).
hasParent2(A,B) :- family(A) , order(B), hasParent(A,B).

commonName(pelecanus,pelican).
commonName(botaurus,bittern).
commonName(ixobrychus,bittern).
commonName(ardea,heron).
commonName(egretta,heron).
commonName(egretta,egret).
commonName(bubulcus,egret).
commonName(butorides,heron).
commonName(nycticorax,nightHeron).
commonName(nyctanassa,nightHeron).
commonName(eudocimus,ibis).
commonName(plegadis,ibis).
commonName(platalea,spoonbill).

commonName(pelecanus_erythrorhynchos,americanWhitePelican).
commonName(pelecanus_occidentalis,brownPelican).
commonName(botaurus_lentiginosus,americanBittern).
commonName(ixobrychus_exilis,leastBittern).
commonName(ardea_herodias,greatBlueHeron).
commonName(ardea_alba,greatEgret).
commonName(egretta_thula,snowyEgret).
commonName(egretta_caerulea,littleBlueHeron).
commonName(egretta_tricolor,tricoloredHeron).
commonName(egretta_rufescens,reddishEgret).
commonName(bubulcus_ibis,cattleEgret).
commonName(butorides_virescens,greenHeron).
commonName(nycticorax_nycticorax,blackCrownedNightHeron).
commonName(nyctanassa_violacea,yellowCrownedNightHeron).
commonName(eudocimus_albus,whiteIbis).
commonName(plegadis_falcinellus,glossyIbis).
commonName(plegadis_chihi,whiteFacedIbis).
commonName(platalea_ajaja,roseateSpoonbill).

%there is overlap when we do nycticorax nycticorax... change common names to have compound names?
%the genus is ok but then actual name needs to be compound
hasCommonName(N,C) :- (order(N);family(N);genus(N)),commonName(N,C).
hasCommonName(N,C) :- hasCompoundName(G,S,N) , commonName(N,C).

hasCommonName(G,S,C) :- hasCompoundName(G,S,N), commonName(N,C).

hasSciName(C,N) :- hasCompoundName(X, Y, N) , commonName(N,C). 
hasSciName(C,N) :- genus(N), commonName(N,C).

hasCompoundName(G,S,N) :- genus(G), species(S), hasParent(S,G), atom_concat('_',S,Z), atom_concat(G,Z,N).


isaStrict(A,B) :- hasCompoundName(G,S,A), hasCompoundName(G,S,B).
isaStrict(A,B) :- A == B, \+species(A), \+species(B), hasParent(X,B).
isaStrict(A,B) :- hasParent2(A,B).
isaStrict(A,B) :- hasParent2(A,X), hasParent2(X,B).
isaStrict(A,B) :- hasParent2(A,X), hasParent2(X,Y), hasParent2(Y,B).

isa(A,B) :- isaStrict(A,B).
isa(A,B) :- commonName(X,A), isaStrict(X,B).
%isa(A,B) :- commonName(X,B), isaStrict(A,X).
isa(A,B) :- commonName(X,B), commonName(Y,A), isaStrict(Y,X).

synonym(A,B) :- (hasCommonName(A,B),A\=B). 
synonym(A,B) :- (hasCommonName(B,A),A\=B).
synonym(A,B) :- (hasCommonName(C,A),hasCommonName(C,B),A\=B).

countSpecies(A,0) :- \+ (order(A) ; family(A);genus(A); hasCompoundName(G,S,A)).
countSpecies(A,1) :- hasCompoundName(G,S,A).
countSpecies(A,N) :- genus(A) -> findall(species(X), hasCompoundName(A,X,Y),List) , length(List, N).
countSpecies(A,N) :- family(A) -> findall(species(X), (hasCompoundName(Z,X,Y),hasParent(Z,A)),List), length(List, N).
countSpecies(A,N) :- order(A) -> findall(species(X), (hasCompoundName(Z,X,Y),hasParent(Z,D),hasParent(D,A)),List), length(List,N).

%rangesTo
rangesTo(A,B) :- (atom(A) , ranges(A,B)); (var(A) , hasCompoundName(_,_,A), ranges(A,B)).
			 
ranges(pelecanus_erythrorhynchos,alberta).
ranges(pelecanus_erythrorhynchos,canada).
ranges(botaurus_lentiginosus,alberta).
ranges(botaurus_lentiginosus,canada).
ranges(ardea_alba,canada).
ranges(ardea_herodias,alberta).
ranges(ardea_herodias,canada).
ranges(bubulcus_ibis,canada).
ranges(butorides_virescens,canada).
ranges(nycticorax_nycticorax,alberta).
ranges(nycticorax_nycticorax,canada).

ranges(pelecanus,alberta).
ranges(pelecanus,canada).
ranges(botaurus,alberta).
ranges(botaurus,canada).
ranges(ardea,alberta).
ranges(ardea,canada).
ranges(nycticorax,alberta).
ranges(nycticorax,canada).

ranges(pelecanidae,alberta).
ranges(pelecanidae,canada).
ranges(ardeiadae,alberta).
ranges(ardeiadae,canada).

ranges(pelecaniformes,alberta).
ranges(pelecaniformes,canada).
ranges2(X,canada).

%habitat
habitat(A,B) :- (atom(A) , habitats(A,B)); (var(A) , hasCompoundName(_,_,A), habitats(A,B)).
			 
habitats(pelecanus_erythrorhynchos, lakePond).
habitats(pelecanus_occidentalis, ocean).
habitats(botaurus_lentiginosus,marsh).
habitats(ixobrychus_exilis, marsh).
habitats(ardea_herodias, marsh).
habitats(ardea_alba, marsh).
habitats(egretta_thula, marsh).
habitats(egretta_caerulea, marsh).
habitats(egretta_tricolor, marsh).
habitats(egretta_rufescens, marsh).
habitats(bubulcus_ibis, marsh).
habitats(butorides_virescens, marsh).
habitats(nycticorax_nycticorax, marsh).
habitats(nyctanassa_violacea, marsh).
habitats(eudocimus_albus, marsh).
habitats(plegadis_falcinellus, marsh).
habitats(plegadis_chihi, marsh).
habitats(platalea_ajaja, marsh).

habitats(pelecanus,lakePond).
habitats(pelecanus,ocean).
habitats(botaurus,marsh).
habitats(ixobrychus,marsh).
habitats(ardea,marsh).
habitats(egretta,marsh).
habitats(bubulcus,marsh).
habitats(butorides,marsh).
habitats(nycticorax,marsh).
habitats(nyctanassa,marsh).
habitats(eudocimus,marsh).
habitats(plegadis,marsh).
habitats(platalea,marsh).

habitats(pelecanidae,lakePond).
habitats(pelecanidae,ocean).
habitats(ardeidae,marsh).
habitats(threskiornithidae,marsh).

habitats(pelecaniformes,lakePond).
habitats(pelecaniformes,ocean).
habitats(pelecaniformes,marsh).

%food
food(A,B) :- (atom(A) , foods(A,B)); (var(A) , hasCompoundName(_,_,A), foods(A,B)).

foods(pelecanus_erythrorhynchos,fish).
foods(pelecanus_occidentalis,fish).
foods(botaurus_lentiginosus,fish).
foods(ixobrychus_exilis,fish).
foods(ardea_herodias,fish).
foods(ardea_alba,fish).
foods(egretta_thula,fish).
foods(egretta_caerulea,fish).
foods(egretta_tricolor,fish).
foods(egretta_rufescens,fish).
foods(bubulcus_ibis,insects).
foods(butorides_virescens,fish).
foods(nycticorax_nycticorax,fish).
foods(nyctanassa_violacea,insects).
foods(eudocimus_albus,insects).
foods(plegadis_falcinellus,insects).
foods(plegadis_chihi,insects).
foods(platalea_ajaja,fish).

foods(pelecanus,fish).
foods(botaurus,fish).
foods(ixobrychus,fish).
foods(ardea,fish).
foods(egretta,fish).
foods(bubulcus,insects).
foods(bubulcus,fish).
foods(nycticorax,fish).
foods(nycticorax,insects).
foods(nyctanassa,insects).
foods(eudocimus,insects).
foods(plegadis,insects).
foods(platalea,fish).

foods(pelecanidae,fish).
foods(ardeidae,fish).
foods(ardeidae,insects).
foods(threskiornithidae,insects).
foods(threskiornithidae,fish).

foods(pelecaniformes,fish).
foods(pelecaniformes,insects).

%nesting
nesting(A,B) :- (atom(A) , nestings(A,B)); (var(A) , hasCompoundName(_,_,A), nestings(A,B)).

nestings(pelecanus_erythrorhynchos,ground).
nestings(pelecanus_occidentalis,tree).
nestings(botaurus_lentiginosus,ground).
nestings(ixobrychus_exilis,ground).
nestings(ardea_herodias,tree).
nestings(ardea_alba,tree).
nestings(egretta_thula,tree).
nestings(egretta_caerulea,tree).
nestings(egretta_tricolor,tree).
nestings(egretta_rufescens,tree).
nestings(bubulcus_ibis,tree).
nestings(butorides_virescens,tree).
nestings(nycticorax_nycticorax,tree).
nestings(nyctanassa_violacea,tree).
nestings(eudocimus_albus,tree).
nestings(plegadis_falcinellus,ground).
nestings(plegadis_chihi,ground).
nestings(platalea_ajaja,tree).

nestings(pelecanus,ground).
nestings(pelecanus,tree).
nestings(botaurus,ground).
nestings(ixobrychus,ground).
nestings(ardea,tree).
nestings(egretta,tree).
nestings(bubulcus,tree).
nestings(nycticorax,tree).
nestings(nyctanassa,tree).
nestings(eudocimus,tree).
nestings(plegadis,ground).
nestings(platalea,tree).

nestings(pelecanidae,ground).
nestings(pelecanidae,tree).
nestings(ardeidae,ground).
nestings(ardeidae,tree).
nestings(threskiornithidae,ground).
nestings(threskiornithidae,tree).

nestings(pelecaniformes,ground).
nestings(pelecaniformes,tree).

%behavior
behavior(A,B) :- (atom(A) , behaviors(A,B)); (var(A) , hasCompoundName(_,_,A), behaviors(A,B)).

			 %surfaceDive, aerialDive, stalking, groundForager, probing
behaviors(pelecanus_erythrorhynchos,surfaceDive).
behaviors(pelecanus_occidentalis,aerialDive).
behaviors(botaurus_lentiginosus,stalking).
behaviors(ixobrychus_exilis,stalking).
behaviors(ardea_herodias,stalking).
behaviors(ardea_alba,stalking).
behaviors(egretta_thula,stalking).
behaviors(egretta_caerulea,stalking).
behaviors(egretta_tricolor,stalking).
behaviors(egretta_rufescens,stalking).
behaviors(bubulcus_ibis,groundForager).
behaviors(butorides_virescens,stalking).
behaviors(nycticorax_nycticorax,stalking).
behaviors(nyctanassa_violacea,stalking).
behaviors(eudocimus_albus,probing).
behaviors(plegadis_falcinellus,probing).
behaviors(plegadis_chihi,probing).
behaviors(platalea_ajaja,probing).

behaviors(pelecanus,surfaceDive).
behaviors(pelecanus,aerialDive).
behaviors(botaurus,stalking).
behaviors(ixobrychus,stalking).
behaviors(ardea,stalking).
behaviors(egretta,stalking).
behaviors(bubulcus,groundForager).
behaviors(nycticorax,stalking).
behaviors(nyctanassa,stalking).
behaviors(eudocimus,probing).
behaviors(plegadis,probing).
behaviors(platalea,probing).

behaviors(pelecanidae,surfaceDive).
behaviors(pelecanidae,aerialDive).
behaviors(ardeidae,stalking).
behaviors(ardeidae,groundForager).
behaviors(threskiornithidae,probing).

behaviors(pelecaniformes,surfaceDive).
behaviors(pelecaniformes,aerialDive).
behaviors(pelecaniformes,stalking).
behaviors(pelecaniformes,groundForager).
behaviors(pelecaniformes,probing).

%conservation
conservation(A,B) :- (atom(A) , conservations(A,B)); (var(A) , hasCompoundName(_,_,A), conservations(A,B)).

conservations(pelecanus_erythrorhynchos,lc).
conservations(pelecanus_occidentalis,lc).
conservations(botaurus_lentiginosus,lc).
conservations(ixobrychus_exilis,lc).
conservations(ardea_herodias,lc).
conservations(ardea_alba,lc).
conservations(egretta_thula,lc).
conservations(egretta_caerulea,lc).
conservations(egretta_tricolor,lc).
conservations(egretta_rufescens,nt).
conservations(bubulcus_ibis,lc).
conservations(butorides_virescens,lc).
conservations(nycticorax_nycticorax,lc).
conservations(nyctanassa_violacea,lc).
conservations(eudocimus_albus,lc).
conservations(plegadis_falcinellus,lc).
conservations(plegadis_chihi,lc).
conservations(platalea_ajaja,lc).

conservations(pelecanus,lc).
conservations(botaurus,lc).
conservations(ixobrychus,lc).
conservations(ardea,lc).
conservations(egretta,lc).
conservations(egretta,nt).
conservations(bubulcus,lc).
conservations(nycticorax,lc).
conservations(nyctanassa,lc).
conservations(eudocimus,lc).
conservations(plegadis,lc).
conservations(platalea,lc).

conservations(pelecanidae,lc).
conservations(ardeidae,lc).
conservations(ardeidae,nt).
conservations(threskiornithidae,lc).

conservations(pelecaniformes,lc).
conservations(pelecaniformes,nt).
