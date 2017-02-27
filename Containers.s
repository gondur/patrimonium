// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const CONTAINER_MEMBERBASE = 40 ; 

// Setup an existing object to be used as container

script setupAsContainer(Container) {
 var ao = activeObject ;  
 if (Container == -1) return false ;

 activeObject = Container ;
 setField(CONTAINER_MEMBERBASE, -1) ;
 
 activeObject = ao ;
 return true ;
}

// Clear contents of a given container
script ResetContainer(Container) { SetupAsContainer(Container) ; }

// Append an item to a container if it does not already hold this item
script AddToContainer(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int i = CONTAINER_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) { 
  i = i + 1; 
  if (obj == Item) { activeObject = ao ; return false ; }
  obj = GetField(i) ; 
 } 
 
 SetField(i,Item) ;
 SetField(i+1,-1) ;
 
 activeObject = ao ;
 return true ;
}

// Append an item to a container even if it is already existing in the container
script AppendToContainer(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int i = CONTAINER_MEMBERBASE + GetContainerSize(Container) ;
 SetField(i,Item) ;
 SetField(i+1,-1) ;
 
 activeObject = ao ;
 return true ;
}

// Remove the first occurence of an item from a container
script RemoveFromContainer(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int pos = -1 ;
 int lst = CONTAINER_MEMBERBASE ;
 var obj = GetField(lst) ;
 while (obj != -1) { 
  if (obj == Item) { pos = lst ; }
  lst = lst + 1; 
  obj = GetField(lst) ;
 } 
 if (pos < 0) { activeObject = ao ; return false ; }
 lst = lst - 1 ;
 
 while (pos != lst) {
  SetField(pos, GetField(pos+1)) ;
  pos = pos + 1 ;
 }
 SetField(lst,-1) ;

 activeObject = ao ;
 return true ;
}

// Remove an item identified by its index from a container
script RemoveFromContainerByIndex(Container,Index) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 
 int pos = CONTAINER_MEMBERBASE + Index ;
 int lst = CONTAINER_MEMBERBASE + (GetContainerSize(Container) - 1) ;
 
 activeObject = Container ;
 while (pos < lst) {
  SetField(pos, GetField(pos+1)) ;
  pos = pos + 1 ;
 }
 SetField(lst,-1) ;

 activeObject = ao ;
 return true ;
}

// returns the index of the first occurence of item inside the container
script LocateInsideContainer(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return -1 ;
 if (Item == -1) return -1 ; 
 activeObject = Container ;

 int i = CONTAINER_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) and (obj != Item) { 
  i = i + 1; 
  obj = GetField(i) ; 
 } 
 if (obj != Item) { activeObject = ao ; return -1 ; }
 
 activeObject = ao ;
 return i - CONTAINER_MEMBERBASE ;
}


// Test if a container contains a given item
script IsInsideContainer(Container,Item) {
 return (LocateInsideContainer(Container,Item) >= 0) ;
}

script ReplaceContainerItemByIndex(Container,Index,ReplaceBy) {
 var ao = activeObject ;
 if (Container == -1) return -1 ;
 if (Index < 0) return -1 ;
 activeObject = Container ;
 
 var old = GetField(CONTAINER_MEMBERBASE + Index) ;
 SetField(CONTAINER_MEMBERBASE + Index,ReplaceBy) ;
 
 activeObject = ao ;
 return old ;
}

script InsertIntoContainer(Container,Index,Item) {
 var ao = activeObject ;
 if (Container == -1) return -1 ;
 if (Index < 0) return -1 ;
 activeObject = Container ;
  
 int size = GetContainerSize(Container) ;
 SetField(CONTAINER_MEMBERBASE + Size + 1, -1) ;
 for (int i=size; i>index; i--) { SetField(CONTAINER_MEMBERBASE + i, GetField(CONTAINER_MEMBERBASE + (i-1)) ); }
 SetField(CONTAINER_MEMBERBASE + Index, Item) ;
 
 activeObject = ao ;
 return 0 ;
}

// Retrieves an item contained within a container by its index
script GetFromContainer(Container, Index) {
 var ao = activeObject ;
 if (Container == -1) return -1 ;
 activeObject = Container ;

 if (Index < 0) { activeObject = ao ; return -1 ; }
 if (Index >= GetContainerSize(Container)) { activeObject = ao ; return -1 ; }
 var obj = GetField(CONTAINER_MEMBERBASE+Index) ;
 
 activeObject = ao ;
 return obj ;
}

// Returns the number of items stored within a container
script GetContainerSize(Container) {
 var ao = activeObject ;
 if (Container == -1) return 0 ;
 activeObject = Container ;
 
 int i = 0 ;
 while (GetField(CONTAINER_MEMBERBASE+i) != -1) { i++; }
 
 activeObject = ao ;
 return i ;
}