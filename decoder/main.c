/**
 * Main program for testing the decoder
 */
#include <stdio.h>
#include "decoder.h"

/*
 * Main
 */
int main()
{
  const char *encoded="\
                       %7JJt%%%^@@=LD=%O7LJ%@D^=7JtJ@W%=@tJ@J@JLt%=%@t@=%=J%7O=^LDL\
                       7=J=%=D7@t@tJJJ@JJW%LWDDO=%7%=J%LL@DJW7DD%=W@%@%JLW%LWL%WJ@L\
                       @JLtm@OD^mJ@t7Jt7@%JLW@@7@=O%JJJ=%J7@@DO%JW7%7%m7LJL%@@L^7=%\
                       J%@t@%LJWmL=WJ%@==%=%J7JL%=%L=DL=DD=@%@%JLWJ@J=J7WW%W%OWL%WJ\
                       D%@=J%m@mmJ7=DJ=%J7^7%^=JOW@DtJ%JL%JmJ=J^7Jt%OW7JLWLOO==%@=D\
                       tJJ%@%%%^@JO=LOm^^=J=7=J@L7@@J%^7W%@@t7^@D^@OJ=JO7JLL%@@L@m=\
                       @mW%t7JJ7@%m=W=%@OJ=WJ%@t^O=@%LJ%@%Dtm7@JDOJ=W^JW%@JtmmmL%Om\
                       %^LW7%7LL=L=%^m%@J%%=J=%=JOO@D=L=JmL%m@7@D@=L%W@@7^JLmJ7=LJO\
                       L@=^L=@mW7Dt7J=%=J%JJ7@=O=JO7LL=^JW%JJODm@LL7@mJ@@DJt7Jt%Om%\
                       mJ^@7@=%LJ^O7JJ777W^L%7O=@%@DL7=%LOmJ=7%JmJJtJJWm=%t7WL=%@mJ\
                       =%7%m%@%LJ%@%@W%t%=JmOJO=J@m@JJ%O@7^J7m7%=DJ%JJ7^J7@=O=WJ%mm\
                       W@W7LJW^LO@L=7D%JJJO=D=J7%^O7JJLJOm7%7=D7@=OO%=WJ@^=%LOm7m@@\
                       t7J%%m7JLW@@JO@LO@%%O%mmJJOO^m7WW@%^J^@L^@J=%@L^^@L@LJtLJtJ@\
                       W7D=J%^^7Wm=W%7WWOOtJ%%O7LJ%Jm^@%@J@L7Ot%m@m@JJ%@J=%^=@=^%WW\
                       JW7JJmLWD@W@^%=JOt%JJ@LLJOm7D%O@J=DJW@%7@t@=@t7LJW%7%O@L@L7^\
                       t%mOW7mD=JJ@L7^7W%=7=D7@D^ODWm@W@@^=L7=%J7LJ%=D7@@LO%D%JJJOJ\
                       O==J^m%^^m%m@m^@LmLW@@7@@L=J@@=%=JDJJ%@@L=J@mmLW%^%^J^mtW%L%\
                       OmJ@LJ=JD%m@@DLJJ%^J7D%=7^O@J=%=^=L7OL%@D@=J@JDJLOJmt@D%JJJ=\
                       %LW%7Wm=7JLWW=W@=^^OJmL%^J@=%OW7@%@=L=7%W=L%^7%@Jm=%m%@DmmLW\
                       mOt%J%mJ@=%=7@DJ=LD=@%7@%J%OWJ^=L";
  char decoded[1000];

  decoder(encoded, decoded, sizeof(decoded));
  printf("%s\n", decoded);

  return 0;
}

