/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#1E1E2E",     /* after initialization */
	[INPUT] =  "#F5C2E7",   /* during input */
	[FAILED] = "#F28FAD",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 75;
/* grid width and height for right center alignment */
static const int logow = 9;
static const int logoh = 6;

static XRectangle rectangles[9] = {
	/* x    y       w       h */
	{  1,   0,      7,      1 },
	{  0,   0,      1,      5 },
	{  1,   4,      7,      1 },
	{  3,   2,      1,      2 },
	{  4,   1,      1,      3 },
	{  2,   2,      1,      1 },
	{  7,   2,      1,      2 },
	{  6,   2,      1,      1 },
};

/*Enable blur*/
#define BLUR
/*Set blur radius*/
static const int blurRadius=20;
/*Enable Pixelation*/
/* #define PIXELATION */
/*Set pixelation radius*/
static const int pixelSize=27;
