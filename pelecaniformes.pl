% Stating facts about the biological database
order(pelecaniformes).

% Families within Pelecaniformes
family(pelecanidae).
family(ardeidae).
family(threskiornithidae).

% Genera within Pelecaniformes
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

% Raw species names within Pelecaniformes
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

% Stating facts about direct parents within Pelecaniformes
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

% B is the direct parent of A
% A must be a family, genus, or compound species name (no raw species names)
% B must be an order, family, or genus name
hasParent2(A,B) :- hasCompoundName(G,S,A) , genus(B), hasParent(S,B).
hasParent2(A,B) :- genus(A) , family(B), hasParent(A,B).
hasParent2(A,B) :- family(A) , order(B), hasParent(A,B).

% Stating facts about common names within Pelecaniformes
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

% N is a taxonomic name and C is the common version of that name
% If N is a species name, it must be a compound name with the genus
hasCommonName(N,C) :- (order(N);family(N);genus(N)),commonName(N,C).
hasCommonName(N,C) :- hasCompoundName(G,S,N) , commonName(N,C).

% The species with genus G and raw species name S has the common name C
hasCommonName(G,S,C) :- hasCompoundName(G,S,N), commonName(N,C).

% N is a taxonomic name and C is the common version of that name
% If N is a species name, it must be a compound name with the genus
% Essentially the reverse of hasCommonName/2
hasSciName(C,N) :- hasCompoundName(X, Y, N) , commonName(N,C). 
hasSciName(C,N) :- (order(N);family(N);genus(N)), commonName(N,C).

% The species with genus G and raw species name S has the compound name N
hasCompoundName(G,S,N) :- genus(G), species(S), hasParent(S,G), atom_concat('_',S,Z), atom_concat(G,Z,N).

% B is an ancestor of A (not necessarily direct) (Note any tier counts as its own ancestor as well)
% A and B may be order names, family names, genus names, compound species names, or variables
% A and B may not be common names and this predicate will not return any common names
isaStrict(A,B) :- hasCompoundName(G,S,A), hasCompoundName(G,S,B).
isaStrict(A,B) :- (order(A); family(A); genus(A)), (order(B); family(B); genus(B)), A = B.
isaStrict(A,B) :- A == B, \+species(A), \+species(B), hasParent(X,B).
isaStrict(A,B) :- hasParent2(A,B).
isaStrict(A,B) :- hasParent2(A,X), hasParent2(X,B).
isaStrict(A,B) :- hasParent2(A,X), hasParent2(X,Y), hasParent2(Y,B).

% B is an ancestor of A (not necessarily direct) (Note any tier counts as its own ancestor as well)
% A and B may be order names, family names, genus names, compound species names, common names, or variables
% A and B may be common names but this predicate will not return any common names
isa(A,B) :- isaStrict(A,B).
isa(A,B) :- (var(A), commonName(X,A), isaStrict(X,B)) -> A = X.
isa(A,B) :- (var(B), commonName(X,B), isaStrict(A,X)) -> B = X.
isa(A,B) :- (var(A), var(B), commonName(X,B), commonName(Y,A), isaStrict(Y,X)) -> (B = X, A = Y).
isa(A,B) :- var(A), commonName(X,B), isaStrict(A,X).
isa(A,B) :- var(B), commonName(X,A), isaStrict(X,B).
isa(A,B) :- \+var(A), \+var(B), (commonName(_,A); commonName(_,B)) -> ((commonName(X,A), isaStrict(X,B)); (commonName(X,B), isaStrict(A,X))).
isa(A,B) :- \+var(A), \+var(B), commonName(X,B), commonName(Y,A), isaStrict(Y,X).

% A and B may be an order name, a family name, a genus name, or a compound species name
% If A is a common name, then B is the taxonomic name of A
% If B is a common name, then A is the taxonomic name of B
% A and B are not the same name
synonym(A,B) :- (hasCommonName(A,B),A\=B). 
synonym(A,B) :- (hasCommonName(B,A),A\=B).
synonym(A,B) :- (hasCommonName(C,A),hasCommonName(C,B),A\=B).

% A may be an order name, a family name, a genus name, or a compound species name
% N is the number of species for which A is the ancestor
countSpecies(A,0) :- \+ (order(A) ; family(A);genus(A); hasCompoundName(G,S,A)).
countSpecies(A,1) :- hasCompoundName(G,S,A).
countSpecies(A,N) :- genus(A) -> findall(species(X), hasCompoundName(A,X,Y),List) , length(List, N).
countSpecies(A,N) :- family(A) -> findall(species(X), (hasCompoundName(Z,X,Y),hasParent(Z,A)),List), length(List, N).
countSpecies(A,N) :- order(A) -> findall(species(X), (hasCompoundName(Z,X,Y),hasParent(Z,D),hasParent(D,A)),List), length(List,N).

% A has a range that extends to P
% A may be an order name, a family name, a genus name, or a compound species name
% P may be either 'canada' or 'alberta'
rangesTo(A,B) :- (atom(A) , ranges(A,B)); (var(A) , hasCompoundName(_,_,A), ranges(A,B)).
			 
% Stating facts about the ranges of the entities within Pelecaniformes
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

% A prefers a habitat of B
% A may be an order name, a family name, a genus name, or a compound species name
% B is either 'lakePond', 'ocean', or 'marsh' and may contain multiple values
habitat(A,B) :- (atom(A) , habitats(A,B)); (var(A) , hasCompoundName(_,_,A), habitats(A,B)).
			 
% Stating facts about the various habitats of the entities within Pelecaniformes
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

% A prefers to eat B
% A may be an order name, a family name, a genus name, or a compound species name
% B is either 'fish' or 'insects' and may contain multiple values
food(A,B) :- (atom(A) , foods(A,B)); (var(A) , hasCompoundName(_,_,A), foods(A,B)).

% Stating facts about the preferred meals of the entities within Pelecaniformes
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

% A prefers to nest in B
% A may be an order name, a family name, a genus name, or a compound species name
% B is either 'ground' or 'tree' and may contain multiple values
nesting(A,B) :- (atom(A) , nestings(A,B)); (var(A) , hasCompoundName(_,_,A), nestings(A,B)).

% Stating facts about the preferred nests of the entities within Pelecaniformes
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

% A exhibits feeding behavior B
% A may be an order name, a family name, a genus name, or a compound species name
% B is either 'surfaceDive', 'aerialDive', 'stalking', 'groundForager', 'probing' and may contain multiple values
behavior(A,B) :- (atom(A) , behaviors(A,B)); (var(A) , hasCompoundName(_,_,A), behaviors(A,B)).

% Stating facts about the various feeding behaviors of the entities within Pelecaniformes
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

% A has a conservation status of B
% A may be an order name, a family name, a genus name, or a compound species name
% B is either 'lc' (low concern) or 'nt' (near threatened) and may contain multiple values
conservation(A,B) :- (atom(A) , conservations(A,B)); (var(A) , hasCompoundName(_,_,A), conservations(A,B)).

% Stating facts about the conservation status of the entities within Pelecaniformes
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