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

commonName(pelecanus,pelican).
	commonName(erythrorhynchos,americanWhitePelican).
	commonName(occidentalis,brownPelican).

commonName(botaurus,bittern).
	commonName(lentiginosus,americanBittern).
commonName(ixobrychus,bittern).
	commonName(exilis,leastBittern).
commonName(ardea,heron).
	commonName(herodias,greatBlueHeron).
	commonName(alba,greatEgret).
commonName(egretta,heron).
commonName(egretta,egret).
	commonName(thula,snowyEgret).
	commonName(caerulea,littleBlueHeron).
	commonName(tricolor,tricoloredHeron).
	commonName(rufescens,reddishEgret).
commonName(bubulcus,egret).
	commonName(ibis,cattleEgret).
commonName(butorides,heron).
	commonName(virescens,greenHeron).
commonName(nycticorax,nightHeron).
	commonName(nycticorax,blackCrownedNightHeron).
commonName(nyctanassa,nightHeron).
	commonName(violacea,yellowCrownedNightHeron).

commonName(eudocimus,ibis).
	commonName(albus,whiteIbis).
commonName(plegadis,ibis).
	commonName(falcinellus,glossyIbis).
	commonName(chihi,whiteFacedIbis).
commonName(platalea,spoonbill).
commonName(ajaja,roseateSpoonbill).

hasCommonName(N,C) :- (order(N);family(N);genus(N)), commonName(N,C).
hasCommonName(N,C) :- commonName(X,C), hasParent(Y,X), atom_concat('_',X,Z), atom_concat(Y,Z).
