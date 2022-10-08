FIND(1)                     General Commands Manual                    FIND(1)

NNAAMMEE
       find - search for files in a directory hierarchy

SSYYNNOOPPSSIISS
       ffiinndd  [-H]  [-L] [-P] [-D debugopts] [-Olevel] [starting-point...] [ex‐
       pression]

DDEESSCCRRIIPPTTIIOONN
       This manual page documents the GNU version of ffiinndd.  GNU ffiinndd  searches
       the  directory  tree  rooted at each given starting-point by evaluating
       the given expression from left to right,  according  to  the  rules  of
       precedence  (see  section  OPERATORS),  until the outcome is known (the
       left hand side is false for _a_n_d operations,  true  for  _o_r),  at  which
       point  ffiinndd  moves  on  to the next file name.  If no starting-point is
       specified, `.' is assumed.

       If you are using ffiinndd in an environment  where  security  is  important
       (for  example  if  you  are  using  it  to  search directories that are
       writable by other users), you should read the `Security Considerations'
       chapter  of  the findutils documentation, which is called FFiinnddiinngg FFiilleess
       and comes with findutils.  That document also includes a lot  more  de‐
       tail  and  discussion  than this manual page, so you may find it a more
       useful source of information.

OOPPTTIIOONNSS
       The --HH, --LL and --PP options control  the  treatment  of  symbolic  links.
       Command-line  arguments  following these are taken to be names of files
       or directories to be examined, up to the  first  argument  that  begins
       with  `-', or the argument `(' or `!'.  That argument and any following
       arguments are taken to be the  expression  describing  what  is  to  be
       searched  for.   If  no paths are given, the current directory is used.
       If no expression is given, the  expression  --pprriinntt  is  used  (but  you
       should probably consider using --pprriinntt00 instead, anyway).

       This  manual  page  talks  about  `options' within the expression list.
       These options control the behaviour of ffiinndd but are  specified  immedi‐
       ately after the last path name.  The five `real' options --HH, --LL, --PP, --DD
       and --OO must appear before the first path name, if  at  all.   A  double
       dash  ---- could theoretically be used to signal that any remaining argu‐
       ments are not options, but this does not really work  due  to  the  way
       ffiinndd  determines  the end of the following path arguments: it does that
       by reading until an expression argument comes (which also starts with a
       `-').   Now, if a path argument would start with a `-', then ffiinndd would
       treat it as expression argument instead.   Thus,  to  ensure  that  all
       start points are taken as such, and especially to prevent that wildcard
       patterns expanded by the calling shell are not  mistakenly  treated  as
       expression  arguments, it is generally safer to prefix wildcards or du‐
       bious path names with either `./' or to use absolute path names  start‐
       ing  with '/'.  Alternatively, it is generally safe though non-portable
       to use the GNU option --ffiilleess00--ffrroomm to pass arbitrary starting points to
       ffiinndd.

       -P     Never  follow  symbolic  links.   This is the default behaviour.
              When ffiinndd examines or prints information about  files,  and  the
              file  is  a  symbolic  link, the information used shall be taken
              from the properties of the symbolic link itself.

       -L     Follow symbolic links.  When ffiinndd examines or prints information
              about  files, the information used shall be taken from the prop‐
              erties of the file to which the link points, not from  the  link
              itself (unless it is a broken symbolic link or ffiinndd is unable to
              examine the file to which the link points).  Use of this  option
              implies  --nnoolleeaaff.   If you later use the --PP option, --nnoolleeaaff will
              still be in effect.  If --LL is in effect  and  ffiinndd  discovers  a
              symbolic link to a subdirectory during its search, the subdirec‐
              tory pointed to by the symbolic link will be searched.

              When the --LL option is in effect, the --ttyyppee predicate will always
              match  against  the type of the file that a symbolic link points
              to rather than the link itself (unless the symbolic link is bro‐
              ken).   Actions  that  can cause symbolic links to become broken
              while ffiinndd is executing (for example --ddeelleettee) can give  rise  to
              confusing  behaviour.   Using  --LL  causes the --llnnaammee and --iillnnaammee
              predicates always to return false.

       -H     Do not follow symbolic links, except while processing  the  com‐
              mand  line  arguments.  When ffiinndd examines or prints information
              about files, the information used shall be taken from the  prop‐
              erties  of the symbolic link itself.  The only exception to this
              behaviour is when a file specified on the command line is a sym‐
              bolic  link,  and the link can be resolved.  For that situation,
              the information used is taken from whatever the link  points  to
              (that is, the link is followed).  The information about the link
              itself is used as a fallback if the file pointed to by the  sym‐
              bolic  link  cannot  be examined.  If --HH is in effect and one of
              the paths specified on the command line is a symbolic link to  a
              directory,  the  contents  of  that  directory  will be examined
              (though of course --mmaaxxddeepptthh 00 would prevent this).

       If more than one of --HH, --LL and --PP is specified, each overrides the oth‐
       ers; the last one appearing on the command line takes effect.  Since it
       is the default, the --PP option should be considered to be in effect  un‐
       less either --HH or --LL is specified.

       GNU  ffiinndd  frequently  stats files during the processing of the command
       line itself, before any searching has begun.  These options also affect
       how those arguments are processed.  Specifically, there are a number of
       tests that compare files listed on the command line against a  file  we
       are  currently  considering.   In  each case, the file specified on the
       command line will have been examined and some of  its  properties  will
       have been saved.  If the named file is in fact a symbolic link, and the
       --PP option is in effect (or if neither --HH nor --LL  were  specified),  the
       information  used  for the comparison will be taken from the properties
       of the symbolic link.  Otherwise, it will be taken from the  properties
       of  the  file  the link points to.  If ffiinndd cannot follow the link (for
       example because it has insufficient privileges or the link points to  a
       nonexistent file) the properties of the link itself will be used.

       When  the  --HH or --LL options are in effect, any symbolic links listed as
       the argument of --nneewweerr will be dereferenced, and the timestamp will  be
       taken  from  the file to which the symbolic link points.  The same con‐
       sideration applies to --nneewweerrXXYY, --aanneewweerr and --ccnneewweerr.

       The --ffoollllooww option has a similar effect to --LL, though it  takes  effect
       at  the  point where it appears (that is, if --LL is not used but --ffoollllooww
       is, any symbolic links appearing after --ffoollllooww on the command line will
       be dereferenced, and those before it will not).

       -D debugopts
              Print  diagnostic  information;  this can be helpful to diagnose
              problems with why ffiinndd is not doing what you want.  The list  of
              debug  options  should be comma separated.  Compatibility of the
              debug options is not guaranteed between releases  of  findutils.
              For  a  complete  list of valid debug options, see the output of
              ffiinndd --DD hheellpp.  Valid debug options include

              exec   Show diagnostic information relating to -exec,  -execdir,
                     -ok and -okdir

              opt    Prints  diagnostic  information relating to the optimisa‐
                     tion of the expression tree; see the -O option.

              rates  Prints a summary indicating how often each predicate suc‐
                     ceeded or failed.

              search Navigate the directory tree verbosely.

              stat   Print  messages  as  files are examined with the ssttaatt and
                     llssttaatt system calls.  The ffiinndd program tries  to  minimise
                     such calls.

              tree   Show  the  expression  tree in its original and optimised
                     form.

              all    Enable all of the other debug options (but hheellpp).

              help   Explain the debugging options.

       -Olevel
              Enables query optimisation.  The ffiinndd program reorders tests  to
              speed up execution while preserving the overall effect; that is,
              predicates with side effects are not reordered relative to  each
              other.   The  optimisations performed at each optimisation level
              are as follows.

              0      Equivalent to optimisation level 1.

              1      This is the default optimisation level and corresponds to
                     the  traditional behaviour.  Expressions are reordered so
                     that tests based only on the names of files (for  example
                     --nnaammee and --rreeggeexx) are performed first.

              2      Any  --ttyyppee  or --xxttyyppee tests are performed after any tests
                     based only on the names of files, but  before  any  tests
                     that  require information from the inode.  On many modern
                     versions of Unix, file types are  returned  by  rreeaaddddiirr(())
                     and so these predicates are faster to evaluate than pred‐
                     icates which need to stat the file first.  If you use the
                     --ffssttyyppee _F_O_O  predicate  and specify a filesystem type _F_O_O
                     which is not known (that is, present in  `/etc/mtab')  at
                     the  time  ffiinndd  starts,  that predicate is equivalent to
                     --ffaallssee.

              3      At this optimisation level, the full cost-based query op‐
                     timiser  is  enabled.   The order of tests is modified so
                     that cheap (i.e. fast) tests are performed first and more
                     expensive ones are performed later, if necessary.  Within
                     each cost band, predicates are evaluated earlier or later
                     according  to  whether they are likely to succeed or not.
                     For --oo, predicates which are likely to succeed are evalu‐
                     ated  earlier, and for --aa, predicates which are likely to
                     fail are evaluated earlier.

              The cost-based optimiser has a fixed  idea  of  how  likely  any
              given  test  is to succeed.  In some cases the probability takes
              account of the specific nature of the test (for example, --ttyyppee ff
              is  assumed  to  be  more  likely to succeed than --ttyyppee cc).  The
              cost-based optimiser is currently being evaluated.  If  it  does
              not actually improve the performance of ffiinndd, it will be removed
              again.  Conversely, optimisations that prove to be reliable, ro‐
              bust  and  effective may be enabled at lower optimisation levels
              over time.  However, the default  behaviour  (i.e.  optimisation
              level  1)  will not be changed in the 4.3.x release series.  The
              findutils test suite runs all the tests on ffiinndd at each  optimi‐
              sation level and ensures that the result is the same.

EEXXPPRREESSSSIIOONN
       The  part  of the command line after the list of starting points is the
       _e_x_p_r_e_s_s_i_o_n.  This is a kind of query specification  describing  how  we
       match  files  and  what we do with the files that were matched.  An ex‐
       pression is composed of a sequence of things:

       Tests  Tests return a true or false value, usually on the basis of some
              property  of a file we are considering.  The --eemmppttyy test for ex‐
              ample is true only when the current file is empty.

       Actions
              Actions have side effects (such as  printing  something  on  the
              standard  output) and return either true or false, usually based
              on whether or not they are successful.  The  --pprriinntt  action  for
              example prints the name of the current file on the standard out‐
              put.

       Global options
              Global options affect the operation of tests and actions  speci‐
              fied on any part of the command line.  Global options always re‐
              turn true.  The --ddeepptthh option for example  makes  ffiinndd  traverse
              the file system in a depth-first order.

       Positional options
              Positional  options  affect  only  tests or actions which follow
              them.  Positional options always return  true.   The  --rreeggeexxttyyppee
              option for example is positional, specifying the regular expres‐
              sion dialect for regular expressions occurring later on the com‐
              mand line.

       Operators
              Operators  join  together the other items within the expression.
              They include for example --oo (meaning logical OR) and --aa (meaning
              logical AND).  Where an operator is missing, --aa is assumed.

       The --pprriinntt action is performed on all files for which the whole expres‐
       sion is true, unless it contains an action other than --pprruunnee or  --qquuiitt.
       Actions  which inhibit the default --pprriinntt are --ddeelleettee, --eexxeecc, --eexxeeccddiirr,
       --ookk, --ookkddiirr, --ffllss, --ffpprriinntt, --ffpprriinnttff, --llss, --pprriinntt and --pprriinnttff.

       The --ddeelleettee action also acts like an option (since it implies --ddeepptthh).

   PPOOSSIITTIIOONNAALL OOPPTTIIOONNSS
       Positional options always return true.  They affect only  tests  occur‐
       ring later on the command line.

       -daystart
              Measure  times  (for  --aammiinn,  --aattiimmee,  --ccmmiinn, --ccttiimmee, --mmmmiinn, and
              --mmttiimmee) from the beginning of today rather than  from  24  hours
              ago.   This  option only affects tests which appear later on the
              command line.

       -follow
              Deprecated; use the --LL  option  instead.   Dereference  symbolic
              links.   Implies --nnoolleeaaff.  The --ffoollllooww option affects only those
              tests which appear after it on the command line.  Unless the  --HH
              or --LL option has been specified, the position of the --ffoollllooww op‐
              tion changes the behaviour of the --nneewweerr  predicate;  any  files
              listed  as  the  argument of --nneewweerr will be dereferenced if they
              are symbolic links.  The same consideration applies to --nneewweerrXXYY,
              --aanneewweerr and --ccnneewweerr.  Similarly, the --ttyyppee predicate will always
              match against the type of the file that a symbolic  link  points
              to rather than the link itself.  Using --ffoollllooww causes the --llnnaammee
              aanndd --iillnnaammee predicates always to return false.

       -regextype _t_y_p_e
              Changes the regular expression syntax understood by  --rreeggeexx  and
              --iirreeggeexx  tests  which  occur  later on the command line.  To see
              which regular expression types are known,  use  --rreeggeexxttyyppee hheellpp.
              The Texinfo documentation (see SSEEEE AALLSSOO) explains the meaning of
              and differences between the various types of regular expression.

       -warn, -nowarn
              Turn warning messages on or off.  These warnings apply  only  to
              the  command  line  usage, not to any conditions that ffiinndd might
              encounter when it searches directories.  The  default  behaviour
              corresponds  to --wwaarrnn if standard input is a tty, and to --nnoowwaarrnn
              otherwise.  If a warning message relating to command-line  usage
              is  produced,  the  exit status of ffiinndd is not affected.  If the
              PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable is set, and --wwaarrnn  is  also
              used,  it  is  not specified which, if any, warnings will be ac‐
              tive.

   GGLLOOBBAALL OOPPTTIIOONNSS
       Global options always return true.  Global options take effect even for
       tests  which  occur earlier on the command line.  To prevent confusion,
       global options should specified on the command-line after the  list  of
       start  points, just before the first test, positional option or action.
       If you specify a global option in some other place, ffiinndd will  issue  a
       warning message explaining that this can be confusing.

       The global options occur after the list of start points, and so are not
       the same kind of option as --LL, for example.

       -d     A synonym for -depth, for compatibility  with  FreeBSD,  NetBSD,
              MacOS X and OpenBSD.

       -depth Process  each  directory's contents before the directory itself.
              The -delete action also implies --ddeepptthh.

       -files0-from _f_i_l_e
              Read the starting points from _f_i_l_e instead of  getting  them  on
              the command line.  In contrast to the known limitations of pass‐
              ing starting points via arguments on the  command  line,  namely
              the limitation of the amount of file names, and the inherent am‐
              biguity of file names clashing with option names, using this op‐
              tion  allows  to  safely  pass  an  arbitrary number of starting
              points to ffiinndd.

              Using this option and passing starting  points  on  the  command
              line  is mutually exclusive, and is therefore not allowed at the
              same time.

              The _f_i_l_e argument is mandatory.  One can use  --ffiilleess00--ffrroomm --  to
              read the list of starting points from the _s_t_a_n_d_a_r_d _i_n_p_u_t stream,
              and e.g. from a pipe.  In this case, the actions --ookk and  --ookkddiirr
              are  not  allowed,  because  they would obviously interfere with
              reading from _s_t_a_n_d_a_r_d _i_n_p_u_t in order to get a user confirmation.

              The starting points in _f_i_l_e have to be separated  by  ASCII  NUL
              characters.   Two  consecutive  NUL characters, i.e., a starting
              point with a Zero-length file name is not allowed and will  lead
              to an error diagnostic followed by a non-Zero exit code later.

              In  the  case the given _f_i_l_e is empty, ffiinndd does not process any
              starting point and therefore will exit immediately after parsing
              the  program  arguments.  This is unlike the standard invocation
              where ffiinndd assumes the current directory as starting point if no
              path argument is passed.

              The  processing  of  the  starting points is otherwise as usual,
              e.g.  ffiinndd will recurse  into  subdirectories  unless  otherwise
              prevented.   To  process only the starting points, one can addi‐
              tionally pass --mmaaxxddeepptthh 00.

              Further notes: if a file is listed more than once in  the  input
              file,  it  is  unspecified whether it is visited more than once.
              If the _f_i_l_e is mutated during the operation of ffiinndd, the  result
              is  unspecified  as well.  Finally, the seek position within the
              named _f_i_l_e at the time ffiinndd exits, be it with --qquuiitt  or  in  any
              other  way, is also unspecified.  By "unspecified" here is meant
              that it may or may not work or do any specific thing,  and  that
              the behavior may change from platform to platform, or from ffiinndd‐‐
              uuttiillss release to release.

       -help, --help
              Print a summary of the command-line usage of ffiinndd and exit.

       -ignore_readdir_race
              Normally, ffiinndd will emit an error message when it fails to  stat
              a  file.   If you give this option and a file is deleted between
              the time ffiinndd reads the name of the file from the directory  and
              the time it tries to stat the file, no error message will be is‐
              sued.  This also applies to files or directories whose names are
              given on the command line.  This option takes effect at the time
              the command line is read, which means that you cannot search one
              part  of  the filesystem with this option on and part of it with
              this option off (if you need to do that, you will need to  issue
              two  ffiinndd  commands instead, one with the option and one without
              it).

              Furthermore, ffiinndd with the --iiggnnoorree__rreeaaddddiirr__rraaccee option will  ig‐
              nore  errors of the --ddeelleettee action in the case the file has dis‐
              appeared since the parent directory was read: it will not output
              an  error  diagnostic, and the return code of the --ddeelleettee action
              will be true.

       -maxdepth _l_e_v_e_l_s
              Descend at most _l_e_v_e_l_s (a non-negative integer) levels of direc‐
              tories  below the starting-points.  Using --mmaaxxddeepptthh 00 means only
              apply the tests and actions to the starting-points themselves.

       -mindepth _l_e_v_e_l_s
              Do not apply any tests or actions at levels less than _l_e_v_e_l_s  (a
              non-negative  integer).   Using  --mmiinnddeepptthh 11  means  process all
              files except the starting-points.

       -mount Don't descend directories on other  filesystems.   An  alternate
              name  for  --xxddeevv,  for compatibility with some other versions of
              ffiinndd.

       -noignore_readdir_race
              Turns off the effect of --iiggnnoorree__rreeaaddddiirr__rraaccee.

       -noleaf
              Do not optimize by assuming that  directories  contain  2  fewer
              subdirectories  than  their  hard  link  count.   This option is
              needed when searching filesystems that do not  follow  the  Unix
              directory-link  convention, such as CD-ROM or MS-DOS filesystems
              or AFS volume mount points.  Each directory  on  a  normal  Unix
              filesystem  has  at least 2 hard links: its name and its `.' en‐
              try.  Additionally, its subdirectories (if any) each have a `..'
              entry linked to that directory.  When ffiinndd is examining a direc‐
              tory, after it has statted 2 fewer subdirectories than  the  di‐
              rectory's  link  count, it knows that the rest of the entries in
              the directory are non-directories (`leaf' files in the directory
              tree).   If  only the files' names need to be examined, there is
              no need to stat them;  this  gives  a  significant  increase  in
              search speed.

       -version, --version
              Print the ffiinndd version number and exit.

       -xdev  Don't descend directories on other filesystems.

   TTEESSTTSS
       Some  tests,  for  example --nneewweerrXXYY and --ssaammeeffiillee, allow comparison be‐
       tween the file currently being examined and some reference file  speci‐
       fied  on  the command line.  When these tests are used, the interpreta‐
       tion of the reference file is determined by the options --HH, --LL  and  --PP
       and any previous --ffoollllooww, but the reference file is only examined once,
       at the time the command line is parsed.  If the reference  file  cannot
       be examined (for example, the ssttaatt(2) system call fails for it), an er‐
       ror message is issued, and ffiinndd exits with a nonzero status.

       A numeric argument _n can be specified to  tests  (like  --aammiinn,  --mmttiimmee,
       --ggiidd, --iinnuumm, --lliinnkkss, --ssiizzee, --uuiidd and --uusseedd) as

       _+_n     for greater than _n,

       _-_n     for less than _n,

       _n      for exactly _n.

       Supported tests:

       -amin _n
              File was last accessed less than, more than or exactly _n minutes
              ago.

       -anewer _r_e_f_e_r_e_n_c_e
              Time of the last access of the current file is more recent  than
              that  of  the  last data modification of the _r_e_f_e_r_e_n_c_e file.  If
              _r_e_f_e_r_e_n_c_e is a symbolic link and the --HH option or the --LL  option
              is in effect, then the time of the last data modification of the
              file it points to is always used.

       -atime _n
              File was last accessed less than,  more  than  or  exactly  _n*24
              hours  ago.   When find figures out how many 24-hour periods ago
              the file was last accessed, any fractional part is  ignored,  so
              to  match  --aattiimmee ++11,  a file has to have been accessed at least
              _t_w_o days ago.

       -cmin _n
              File's status was last changed less than, more than or exactly _n
              minutes ago.

       -cnewer _r_e_f_e_r_e_n_c_e
              Time  of  the last status change of the current file is more re‐
              cent than that of the last data modification  of  the  _r_e_f_e_r_e_n_c_e
              file.   If _r_e_f_e_r_e_n_c_e is a symbolic link and the --HH option or the
              --LL option is in effect, then the time of the last data modifica‐
              tion of the file it points to is always used.

       -ctime _n
              File's  status  was last changed less than, more than or exactly
              _n*24 hours ago.  See the comments for --aattiimmee to  understand  how
              rounding affects the interpretation of file status change times.

       -empty File is empty and is either a regular file or a directory.

       -executable
              Matches  files  which  are  executable and directories which are
              searchable (in a file name  resolution  sense)  by  the  current
              user.   This  takes  into account access control lists and other
              permissions artefacts which the --ppeerrmm test ignores.   This  test
              makes  use of the aacccceessss(2) system call, and so can be fooled by
              NFS servers which do UID mapping (or root-squashing), since many
              systems implement aacccceessss(2) in the client's kernel and so cannot
              make use of the UID mapping information held on the server.  Be‐
              cause  this  test  is  based only on the result of the aacccceessss(2)
              system call, there is no guarantee that a file  for  which  this
              test succeeds can actually be executed.

       -false Always false.

       -fstype _t_y_p_e
              File  is  on  a  filesystem  of type _t_y_p_e.  The valid filesystem
              types vary among different versions of Unix; an incomplete  list
              of filesystem types that are accepted on some version of Unix or
              another is: ufs, 4.2, 4.3, nfs, tmp, mfs, S51K, S52K.   You  can
              use  --pprriinnttff  with  the  %F  directive  to see the types of your
              filesystems.

       -gid _n File's numeric group ID is less than, more than or exactly _n.

       -group _g_n_a_m_e
              File belongs to group _g_n_a_m_e (numeric group ID allowed).

       -ilname _p_a_t_t_e_r_n
              Like --llnnaammee, but the match is case insensitive.  If the  --LL  op‐
              tion or the --ffoollllooww option is in effect, this test returns false
              unless the symbolic link is broken.

       -iname _p_a_t_t_e_r_n
              Like --nnaammee, but the match is case insensitive.  For example, the
              patterns  `fo*'  and  `F??'  match  the file names `Foo', `FOO',
              `foo', `fOo', etc.  The pattern `*foo*` will also match  a  file
              called '.foobar'.

       -inum _n
              File  has  inode number smaller than, greater than or exactly _n.
              It is normally easier to use the --ssaammeeffiillee test instead.

       -ipath _p_a_t_t_e_r_n
              Like --ppaatthh.  but the match is case insensitive.

       -iregex _p_a_t_t_e_r_n
              Like --rreeggeexx, but the match is case insensitive.

       -iwholename _p_a_t_t_e_r_n
              See -ipath.  This alternative is less portable than --iippaatthh.

       -links _n
              File has less than, more than or exactly _n hard links.

       -lname _p_a_t_t_e_r_n
              File is a symbolic link whose contents match shell pattern  _p_a_t_‐
              _t_e_r_n.  The metacharacters do not treat `/' or `.' specially.  If
              the --LL option or the --ffoollllooww option is in effect, this test  re‐
              turns false unless the symbolic link is broken.

       -mmin _n
              File's  data was last modified less than, more than or exactly _n
              minutes ago.

       -mtime _n
              File's data was last modified less than, more  than  or  exactly
              _n*24  hours  ago.  See the comments for --aattiimmee to understand how
              rounding affects the interpretation of file modification times.

       -name _p_a_t_t_e_r_n
              Base of file name (the path with  the  leading  directories  re‐
              moved)  matches  shell pattern _p_a_t_t_e_r_n.  Because the leading di‐
              rectories are removed, the file names  considered  for  a  match
              with --nnaammee will never include a slash, so `-name a/b' will never
              match anything (you probably need  to  use  --ppaatthh  instead).   A
              warning  is issued if you try to do this, unless the environment
              variable PPOOSSIIXXLLYY__CCOORRRREECCTT is set.  The metacharacters (`*',  `?',
              and  `[]')  match a `.' at the start of the base name (this is a
              change in findutils-4.2.2; see section STANDARDS CONFORMANCE be‐
              low).   To ignore a directory and the files under it, use --pprruunnee
              rather than checking every file in the tree; see an  example  in
              the  description  of  that action.  Braces are not recognised as
              being special, despite the fact that some shells including  Bash
              imbue  braces  with  a  special  meaning in shell patterns.  The
              filename matching is performed with the use  of  the  ffnnmmaattcchh(3)
              library function.  Don't forget to enclose the pattern in quotes
              in order to protect it from expansion by the shell.

       -newer _r_e_f_e_r_e_n_c_e
              Time of the last data modification of the current file  is  more
              recent  than that of the last data modification of the _r_e_f_e_r_e_n_c_e
              file.  If _r_e_f_e_r_e_n_c_e is a symbolic link and the --HH option or  the
              --LL option is in effect, then the time of the last data modifica‐
              tion of the file it points to is always used.

       -newerXY _r_e_f_e_r_e_n_c_e
              Succeeds if timestamp _X of the file being  considered  is  newer
              than timestamp _Y of the file _r_e_f_e_r_e_n_c_e.  The letters _X and _Y can
              be any of the following letters:

              a   The access time of the file _r_e_f_e_r_e_n_c_e
              B   The birth time of the file _r_e_f_e_r_e_n_c_e
              c   The inode status change time of _r_e_f_e_r_e_n_c_e
              m   The modification time of the file _r_e_f_e_r_e_n_c_e
              t   _r_e_f_e_r_e_n_c_e is interpreted directly as a time

              Some combinations are invalid; for example, it is invalid for  _X
              to  be _t.  Some combinations are not implemented on all systems;
              for example _B is not supported on all systems.  If an invalid or
              unsupported  combination  of  _X_Y is specified, a fatal error re‐
              sults.  Time specifications are interpreted as for the  argument
              to  the --dd option of GNU ddaattee.  If you try to use the birth time
              of a reference file, and the birth time cannot be determined,  a
              fatal error message results.  If you specify a test which refers
              to the birth time of files being examined, this test  will  fail
              for any files where the birth time is unknown.

       -nogroup
              No group corresponds to file's numeric group ID.

       -nouser
              No user corresponds to file's numeric user ID.

       -path _p_a_t_t_e_r_n
              File  name matches shell pattern _p_a_t_t_e_r_n.  The metacharacters do
              not treat `/' or `.' specially; so, for example,
                  find . -path "./sr*sc"
              will print an entry for a directory called  _._/_s_r_c_/_m_i_s_c  (if  one
              exists).   To  ignore  a whole directory tree, use --pprruunnee rather
              than checking every file in the tree.   Note  that  the  pattern
              match  test applies to the whole file name, starting from one of
              the start points named on the command line.  It would only  make
              sense  to  use  an absolute path name here if the relevant start
              point is also an absolute path.  This means  that  this  command
              will never match anything:
                  find bar -path /foo/bar/myfile -print
              Find compares the --ppaatthh argument with the concatenation of a di‐
              rectory name and the base  name  of  the  file  it's  examining.
              Since the concatenation will never end with a slash, --ppaatthh argu‐
              ments ending in a slash will match  nothing  (except  perhaps  a
              start point specified on the command line).  The predicate --ppaatthh
              is also supported by HP-UX ffiinndd and is part of  the  POSIX  2008
              standard.

       -perm _m_o_d_e
              File's  permission  bits  are  exactly _m_o_d_e (octal or symbolic).
              Since an exact match is required, if you want to use  this  form
              for  symbolic  modes,  you  may have to specify a rather complex
              mode string.  For example `-perm  g=w'  will  only  match  files
              which  have  mode 0020 (that is, ones for which group write per‐
              mission is the only permission set).  It is more likely that you
              will want to use the `/' or `-' forms, for example `-perm -g=w',
              which matches any file with group write permission.  See the EEXX‐‐
              AAMMPPLLEESS section for some illustrative examples.

       -perm -_m_o_d_e
              All  of the permission bits _m_o_d_e are set for the file.  Symbolic
              modes are accepted in this form, and this is usually the way  in
              which  you would want to use them.  You must specify `u', `g' or
              `o' if you use a symbolic mode.  See the  EEXXAAMMPPLLEESS  section  for
              some illustrative examples.

       -perm /_m_o_d_e
              Any  of the permission bits _m_o_d_e are set for the file.  Symbolic
              modes are accepted in this form.  You must specify `u',  `g'  or
              `o'  if  you  use a symbolic mode.  See the EEXXAAMMPPLLEESS section for
              some illustrative examples.  If no permission bits in  _m_o_d_e  are
              set,  this test matches any file (the idea here is to be consis‐
              tent with the behaviour of --ppeerrmm --000000).

       -perm +_m_o_d_e
              This is no longer  supported  (and  has  been  deprecated  since
              2005).  Use --ppeerrmm //_m_o_d_e instead.

       -readable
              Matches  files  which  are  readable  by the current user.  This
              takes into account access control lists  and  other  permissions
              artefacts  which the --ppeerrmm test ignores.  This test makes use of
              the aacccceessss(2) system call, and so can be fooled by  NFS  servers
              which do UID mapping (or root-squashing), since many systems im‐
              plement aacccceessss(2) in the client's kernel and so cannot make  use
              of the UID mapping information held on the server.

       -regex _p_a_t_t_e_r_n
              File  name  matches regular expression _p_a_t_t_e_r_n.  This is a match
              on the whole path, not a search.  For example, to match  a  file
              named  _._/_f_u_b_a_r_3_,  you can use the regular expression `.*bar.' or
              `.*b.*3', but not `f.*r3'.  The regular  expressions  understood
              by  ffiinndd  are  by default Emacs Regular Expressions (except that
              `.' matches newline), but this can be changed with  the  --rreeggeexx‐‐
              ttyyppee option.

       -samefile _n_a_m_e
              File  refers  to  the same inode as _n_a_m_e.  When --LL is in effect,
              this can include symbolic links.

       -size _n[cwbkMG]
              File uses less than, more than or  exactly  _n  units  of  space,
              rounding up.  The following suffixes can be used:

              `b'    for  512-byte blocks (this is the default if no suffix is
                     used)

              `c'    for bytes

              `w'    for two-byte words

              `k'    for kibibytes (KiB, units of 1024 bytes)

              `M'    for mebibytes (MiB, units of 1024 * 1024 = 1048576 bytes)

              `G'    for gibibytes (GiB,  units  of  1024  *  1024  *  1024  =
                     1073741824 bytes)

              The  size  is simply the st_size member of the struct stat popu‐
              lated by the lstat (or stat) system call, rounded  up  as  shown
              above.   In other words, it's consistent with the result you get
              for llss --ll.  Bear in mind that the `%k' and  `%b'  format  speci‐
              fiers  of --pprriinnttff handle sparse files differently.  The `b' suf‐
              fix always denotes 512-byte blocks and never  1024-byte  blocks,
              which is different to the behaviour of --llss.

              The  +  and  -  prefixes  signify greater than and less than, as
              usual; i.e., an exact size of _n units does not match.   Bear  in
              mind  that  the  size is rounded up to the next unit.  Therefore
              --ssiizzee --11MM is not equivalent to --ssiizzee --11004488557766cc.  The former only
              matches  empty  files,  the  latter  matches  files  from  0  to
              1,048,575 bytes.

       -true  Always true.

       -type _c
              File is of type _c:

              b      block (buffered) special

              c      character (unbuffered) special

              d      directory

              p      named pipe (FIFO)

              f      regular file

              l      symbolic link; this is never true if the --LL option or the
                     --ffoollllooww  option is in effect, unless the symbolic link is
                     broken.  If you want to search for symbolic links when --LL
                     is in effect, use --xxttyyppee.

              s      socket

              D      door (Solaris)

              To  search  for  more  than one type at once, you can supply the
              combined list of type letters separated by a comma `,' (GNU  ex‐
              tension).

       -uid _n File's numeric user ID is less than, more than or exactly _n.

       -used _n
              File  was  last  accessed less than, more than or exactly _n days
              after its status was last changed.

       -user _u_n_a_m_e
              File is owned by user _u_n_a_m_e (numeric user ID allowed).

       -wholename _p_a_t_t_e_r_n
              See -path.  This alternative is less portable than --ppaatthh.

       -writable
              Matches files which are writable  by  the  current  user.   This
              takes  into  account  access control lists and other permissions
              artefacts which the --ppeerrmm test ignores.  This test makes use  of
              the  aacccceessss(2)  system call, and so can be fooled by NFS servers
              which do UID mapping (or root-squashing), since many systems im‐
              plement  aacccceessss(2) in the client's kernel and so cannot make use
              of the UID mapping information held on the server.

       -xtype _c
              The same as --ttyyppee unless the file is a symbolic link.  For  sym‐
              bolic  links:  if the --HH or --PP option was specified, true if the
              file is a link to a file of type _c; if the --LL  option  has  been
              given,  true  if  _c is `l'.  In other words, for symbolic links,
              --xxttyyppee checks the type of the file that --ttyyppee does not check.

       -context _p_a_t_t_e_r_n
              (SELinux only) Security context of the file  matches  glob  _p_a_t_‐
              _t_e_r_n.

   AACCTTIIOONNSS
       -delete
              Delete  files or directories; true if removal succeeded.  If the
              removal failed, an error message is issued and ffiinndd's exit  sta‐
              tus will be nonzero (when it eventually exits).

              WWaarrnniinngg: Don't forget that ffiinndd evaluates the command line as an
              expression, so putting --ddeelleettee  first  will  make  ffiinndd  try  to
              delete everything below the starting points you specified.

              The  use of the --ddeelleettee action on the command line automatically
              turns on the --ddeepptthh option.  As in turn --ddeepptthh makes --pprruunnee  in‐
              effective,  the  --ddeelleettee action cannot usefully be combined with
              --pprruunnee.

              Often, the user might want to test  a  find  command  line  with
              --pprriinntt  prior  to adding --ddeelleettee for the actual removal run.  To
              avoid surprising results, it is usually best to remember to  use
              --ddeepptthh explicitly during those earlier test runs.

              The  --ddeelleettee action will fail to remove a directory unless it is
              empty.

              Together with the --iiggnnoorree__rreeaaddddiirr__rraaccee option, ffiinndd will  ignore
              errors  of  the  --ddeelleettee  action in the case the file has disap‐
              peared since the parent directory was read: it will  not  output
              an  error  diagnostic,  not change the exit code to nonzero, and
              the return code of the --ddeelleettee action will be true.

       -exec _c_o_m_m_a_n_d ;
              Execute _c_o_m_m_a_n_d; true if 0 status is  returned.   All  following
              arguments to ffiinndd are taken to be arguments to the command until
              an argument consisting of `;' is encountered.  The  string  `{}'
              is  replaced by the current file name being processed everywhere
              it occurs in the arguments to the command, not just in arguments
              where  it  is alone, as in some versions of ffiinndd.  Both of these
              constructions might need to be escaped (with a `\') or quoted to
              protect them from expansion by the shell.  See the EEXXAAMMPPLLEESS sec‐
              tion for examples of the use of the --eexxeecc option.  The specified
              command  is run once for each matched file.  The command is exe‐
              cuted in the starting directory.  There are unavoidable security
              problems surrounding use of the --eexxeecc action; you should use the
              --eexxeeccddiirr option instead.

       -exec _c_o_m_m_a_n_d {} +
              This variant of the --eexxeecc action runs the specified  command  on
              the  selected  files, but the command line is built by appending
              each selected file name at the end; the total number of  invoca‐
              tions  of  the  command  will  be  much  less than the number of
              matched files.  The command line is built in much the  same  way
              that  xxaarrggss builds its command lines.  Only one instance of `{}'
              is allowed within the command, and it must appear  at  the  end,
              immediately  before the `+'; it needs to be escaped (with a `\')
              or quoted to protect it from interpretation by the  shell.   The
              command  is  executed in the starting directory.  If any invoca‐
              tion with the `+' form returns a non-zero value as exit  status,
              then ffiinndd returns a non-zero exit status.  If ffiinndd encounters an
              error, this can sometimes cause an immediate exit, so some pend‐
              ing  commands  may not be run at all.  For this reason --eexxeecc _m_y_-
              _c_o_m_m_a_n_d ...... {{}} ++ --qquuiitt may not result in _m_y_-_c_o_m_m_a_n_d actually be‐
              ing run.  This variant of --eexxeecc always returns true.

       -execdir _c_o_m_m_a_n_d ;

       -execdir _c_o_m_m_a_n_d {} +
              Like  --eexxeecc, but the specified command is run from the subdirec‐
              tory containing the matched file, which is not normally the  di‐
              rectory in which you started ffiinndd.  As with -exec, the {} should
              be quoted if find is being invoked from a shell.   This  a  much
              more secure method for invoking commands, as it avoids race con‐
              ditions during resolution of the paths to the matched files.  As
              with  the  --eexxeecc  action,  the `+' form of --eexxeeccddiirr will build a
              command line to process more than  one  matched  file,  but  any
              given  invocation  of _c_o_m_m_a_n_d will only list files that exist in
              the same subdirectory.  If you use this option, you must  ensure
              that your PPAATTHH environment variable does not reference `.'; oth‐
              erwise, an attacker can run any commands they like by leaving an
              appropriately-named  file  in  a directory in which you will run
              --eexxeeccddiirr.  The same applies to having entries in PPAATTHH which  are
              empty or which are not absolute directory names.  If any invoca‐
              tion with the `+' form returns a non-zero value as exit  status,
              then ffiinndd returns a non-zero exit status.  If ffiinndd encounters an
              error, this can sometimes cause an immediate exit, so some pend‐
              ing  commands  may  not be run at all.  The result of the action
              depends on whether the ++ or the ;; variant is  being  used;  --eexx‐‐
              eeccddiirr _c_o_m_m_a_n_d {{}} ++  always  returns  true,  while  --eexxeeccddiirr _c_o_m_‐
              _m_a_n_d {{}} ;; returns true only if _c_o_m_m_a_n_d returns 0.

       -fls _f_i_l_e
              True; like --llss but write to _f_i_l_e like --ffpprriinntt.  The output  file
              is  always created, even if the predicate is never matched.  See
              the UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information about how  unusual
              characters in filenames are handled.

       -fprint _f_i_l_e
              True; print the full file name into file _f_i_l_e.  If _f_i_l_e does not
              exist when ffiinndd is run, it is created; if it does exist,  it  is
              truncated.   The file names _/_d_e_v_/_s_t_d_o_u_t and _/_d_e_v_/_s_t_d_e_r_r are han‐
              dled specially; they refer to the standard output  and  standard
              error  output, respectively.  The output file is always created,
              even if the predicate is never matched.  See the  UUNNUUSSUUAALL  FFIILLEE‐‐
              NNAAMMEESS  section  for  information about how unusual characters in
              filenames are handled.

       -fprint0 _f_i_l_e
              True; like --pprriinntt00 but write to _f_i_l_e like --ffpprriinntt.   The  output
              file  is always created, even if the predicate is never matched.
              See the UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information about how  un‐
              usual characters in filenames are handled.

       -fprintf _f_i_l_e _f_o_r_m_a_t
              True;  like  --pprriinnttff but write to _f_i_l_e like --ffpprriinntt.  The output
              file is always created, even if the predicate is never  matched.
              See  the UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information about how un‐
              usual characters in filenames are handled.

       -ls    True; list current file in llss --ddiillss format on  standard  output.
              The  block  counts  are  of  1 KB blocks, unless the environment
              variable PPOOSSIIXXLLYY__CCOORRRREECCTT is set, in which case  512-byte  blocks
              are  used.   See  the  UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information
              about how unusual characters in filenames are handled.

       -ok _c_o_m_m_a_n_d ;
              Like --eexxeecc but ask the user first.  If the user agrees, run  the
              command.   Otherwise  just return false.  If the command is run,
              its standard input is redirected from  _/_d_e_v_/_n_u_l_l.   This  action
              may not be specified together with the --ffiilleess00--ffrroomm option.

              The  response to the prompt is matched against a pair of regular
              expressions to determine if it is an affirmative or negative re‐
              sponse.   This regular expression is obtained from the system if
              the PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable is  set,  or  otherwise
              from ffiinndd's message translations.  If the system has no suitable
              definition, ffiinndd's own definition will be used.  In either case,
              the  interpretation of the regular expression itself will be af‐
              fected by the environment variables LLCC__CCTTYYPPEE (character classes)
              and LLCC__CCOOLLLLAATTEE (character ranges and equivalence classes).

       -okdir _c_o_m_m_a_n_d ;
              Like --eexxeeccddiirr but ask the user first in the same way as for --ookk.
              If the user does not agree, just return false.  If  the  command
              is  run,  its standard input is redirected from _/_d_e_v_/_n_u_l_l.  This
              action may not be specified together with the  --ffiilleess00--ffrroomm  op‐
              tion.

       -print True;  print the full file name on the standard output, followed
              by a newline.  If you are piping the output of ffiinndd into another
              program  and  there  is  the faintest possibility that the files
              which you are searching for might contain a  newline,  then  you
              should  seriously  consider  using the --pprriinntt00 option instead of
              --pprriinntt.  See the UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information about
              how unusual characters in filenames are handled.

       -print0
              True;  print the full file name on the standard output, followed
              by a null character  (instead  of  the  newline  character  that
              --pprriinntt  uses).   This allows file names that contain newlines or
              other types of white space to be correctly interpreted  by  pro‐
              grams  that process the ffiinndd output.  This option corresponds to
              the --00 option of xxaarrggss.

       -printf _f_o_r_m_a_t
              True; print _f_o_r_m_a_t on the standard output, interpreting `\'  es‐
              capes  and  `%'  directives.  Field widths and precisions can be
              specified as with the pprriinnttff(3) C function.   Please  note  that
              many  of  the  fields are printed as %s rather than %d, and this
              may mean that flags don't work as you might expect.   This  also
              means  that the `-' flag does work (it forces fields to be left-
              aligned).  Unlike --pprriinntt, --pprriinnttff does not add a newline at  the
              end of the string.  The escapes and directives are:

              \a     Alarm bell.

              \b     Backspace.

              \c     Stop  printing from this format immediately and flush the
                     output.

              \f     Form feed.

              \n     Newline.

              \r     Carriage return.

              \t     Horizontal tab.

              \v     Vertical tab.

              \0     ASCII NUL.

              \\     A literal backslash (`\').

              \NNN   The character whose ASCII code is NNN (octal).

              A `\' character followed by any other character is treated as an
              ordinary character, so they both are printed.

              %%     A literal percent sign.

              %a     File's  last  access time in the format returned by the C
                     ccttiimmee(3) function.

              %A_k    File's last access time in the  format  specified  by  _k,
                     which  is either `@' or a directive for the C ssttrrffttiimmee(3)
                     function.  The following shows an incomplete list of pos‐
                     sible values for _k.  Please refer to the documentation of
                     ssttrrffttiimmee(3) for the full list.  Some  of  the  conversion
                     specification  characters  might  not be available on all
                     systems, due to differences in the implementation of  the
                     ssttrrffttiimmee(3) library function.

                     @      seconds  since Jan. 1, 1970, 00:00 GMT, with frac‐
                            tional part.

                     Time fields:

                     H      hour (00..23)

                     I      hour (01..12)

                     k      hour ( 0..23)

                     l      hour ( 1..12)

                     M      minute (00..59)

                     p      locale's AM or PM

                     r      time, 12-hour (hh:mm:ss [AP]M)

                     S      Second (00.00 .. 61.00).  There  is  a  fractional
                            part.

                     T      time, 24-hour (hh:mm:ss.xxxxxxxxxx)

                     +      Date  and  time,  separated  by  `+',  for example
                            `2004-04-28+22:22:05.0'.  This is a GNU extension.
                            The  time  is given in the current timezone (which
                            may be affected  by  setting  the  TTZZ  environment
                            variable).   The  seconds  field  includes a frac‐
                            tional part.

                     X      locale's time representation (H:M:S).  The seconds
                            field includes a fractional part.

                     Z      time  zone (e.g., EDT), or nothing if no time zone
                            is determinable

                     Date fields:

                     a      locale's abbreviated weekday name (Sun..Sat)

                     A      locale's full weekday name, variable length  (Sun‐
                            day..Saturday)

                     b      locale's abbreviated month name (Jan..Dec)

                     B      locale's  full  month name, variable length (Janu‐
                            ary..December)

                     c      locale's date and time (Sat Nov  04  12:02:33  EST
                            1989).  The format is the same as for ccttiimmee(3) and
                            so to preserve  compatibility  with  that  format,
                            there is no fractional part in the seconds field.

                     d      day of month (01..31)

                     D      date (mm/dd/yy)

                     F      date (yyyy-mm-dd)

                     h      same as b

                     j      day of year (001..366)

                     m      month (01..12)

                     U      week  number  of  year with Sunday as first day of
                            week (00..53)

                     w      day of week (0..6)

                     W      week number of year with Monday as  first  day  of
                            week (00..53)

                     x      locale's date representation (mm/dd/yy)

                     y      last two digits of year (00..99)

                     Y      year (1970...)

              %b     The  amount  of disk space used for this file in 512-byte
                     blocks.  Since disk space is allocated  in  multiples  of
                     the  filesystem  block  size this is usually greater than
                     %s/512, but it can also be  smaller  if  the  file  is  a
                     sparse file.

              %B_k    File's birth time, i.e., its creation time, in the format
                     specified by _k, which is the same as for %A.  This direc‐
                     tive produces an empty string if the underlying operating
                     system or filesystem does not support birth times.

              %c     File's last status change time in the format returned  by
                     the C ccttiimmee(3) function.

              %C_k    File's last status change time in the format specified by
                     _k, which is the same as for %A.

              %d     File's depth in the directory tree; 0 means the file is a
                     starting-point.

              %D     The  device  number  on which the file exists (the st_dev
                     field of struct stat), in decimal.

              %f     Print the basename; the file's name with any leading  di‐
                     rectories  removed  (only  the last element).  For //, the
                     result is `/'.  See the EEXXAAMMPPLLEESS section for an example.

              %F     Type of the filesystem the file is on; this value can  be
                     used for -fstype.

              %g     File's  group  name, or numeric group ID if the group has
                     no name.

              %G     File's numeric group ID.

              %h     Dirname; the Leading directories of the file's name  (all
                     but  the  last  element).   If  the file name contains no
                     slashes (since it is in the  current  directory)  the  %h
                     specifier expands to `.'.  For files which are themselves
                     directories and contain a slash (including //), %h expands
                     to the empty string.  See the EEXXAAMMPPLLEESS section for an ex‐
                     ample.

              %H     Starting-point under which file was found.

              %i     File's inode number (in decimal).

              %k     The amount of disk space  used  for  this  file  in  1 KB
                     blocks.   Since  disk  space is allocated in multiples of
                     the filesystem block size this is  usually  greater  than
                     %s/1024,  but  it  can  also  be smaller if the file is a
                     sparse file.

              %l     Object of symbolic link (empty string if file  is  not  a
                     symbolic link).

              %m     File's  permission bits (in octal).  This option uses the
                     `traditional' numbers  which  most  Unix  implementations
                     use,  but  if  your particular implementation uses an un‐
                     usual ordering of octal permissions bits, you will see  a
                     difference  between  the  actual value of the file's mode
                     and the output of %m.  Normally you will want to  have  a
                     leading  zero  on this number, and to do this, you should
                     use the ## flag (as in, for example, `%#m').

              %M     File's permissions (in symbolic form, as for  llss).   This
                     directive is supported in findutils 4.2.5 and later.

              %n     Number of hard links to file.

              %p     File's name.

              %P     File's  name  with  the  name of the starting-point under
                     which it was found removed.

              %s     File's size in bytes.

              %S     File's  sparseness.   This  is  calculated   as   (BLOCK‐
                     SIZE*st_blocks  / st_size).  The exact value you will get
                     for an ordinary file of a certain length is system-depen‐
                     dent.   However,  normally  sparse files will have values
                     less than 1.0, and files which use  indirect  blocks  may
                     have  a  value which is greater than 1.0.  In general the
                     number of blocks used by a file is file system dependent.
                     The  value used for BLOCKSIZE is system-dependent, but is
                     usually 512 bytes.  If the file size is zero,  the  value
                     printed  is undefined.  On systems which lack support for
                     st_blocks, a file's sparseness is assumed to be 1.0.

              %t     File's last modification time in the format  returned  by
                     the C ccttiimmee(3) function.

              %T_k    File's  last modification time in the format specified by
                     _k, which is the same as for %A.

              %u     File's user name, or numeric user ID if the user  has  no
                     name.

              %U     File's numeric user ID.

              %y     File's  type  (like  in llss --ll), U=unknown type (shouldn't
                     happen)

              %Y     File's  type  (like  %y),  plus  follow  symbolic  links:
                     `L'=loop,  `N'=nonexistent,  `?' for any other error when
                     determining the type of the target of a symbolic link.

              %Z     (SELinux only) file's security context.

              %{ %[ %(
                     Reserved for future use.

              A `%' character followed by any other  character  is  discarded,
              but  the other character is printed (don't rely on this, as fur‐
              ther format characters may be introduced).  A `%' at the end  of
              the format argument causes undefined behaviour since there is no
              following character.  In some locales, it  may  hide  your  door
              keys,  while  in  others  it  may remove the final page from the
              novel you are reading.

              The %m and %d directives support the ##, 00 and ++ flags,  but  the
              other  directives  do  not, even if they print numbers.  Numeric
              directives that do not support these flags include GG, UU, bb, DD, kk
              and  nn.  The `-' format flag is supported and changes the align‐
              ment of a field from right-justified (which is the  default)  to
              left-justified.

              See  the UUNNUUSSUUAALL FFIILLEENNAAMMEESS section for information about how un‐
              usual characters in filenames are handled.

       -prune True; if the file is a directory, do not descend  into  it.   If
              --ddeepptthh is given, then --pprruunnee has no effect.  Because --ddeelleettee im‐
              plies --ddeepptthh, you cannot usefully use  --pprruunnee  and  --ddeelleettee  to‐
              gether.   For  example,  to skip the directory _s_r_c_/_e_m_a_c_s and all
              files and directories under it, and print the names of the other
              files found, do something like this:
                  find . -path ./src/emacs -prune -o -print

       -quit  Exit  immediately  (with return value zero if no errors have oc‐
              curred).  This is different to --pprruunnee because  --pprruunnee  only  ap‐
              plies  to the contents of pruned directories, while --qquuiitt simply
              makes ffiinndd stop immediately.  No child processes  will  be  left
              running.  Any command lines which have been built by --eexxeecc ...... ++
              or --eexxeeccddiirr ...... ++ are invoked before the program is exited.  Af‐
              ter  --qquuiitt  is  executed, no more files specified on the command
              line      will      be      processed.        For       example,
              `ffiinndd _/_t_m_p_/_f_o_o _/_t_m_p_/_b_a_r --pprriinntt --qquuiitt`     will     print    only
              `/tmp/foo`.
              One common use of --qquuiitt is to stop  searching  the  file  system
              once  we  have  found  what we want.  For example, if we want to
              find just a single file we can do this:
                  find / -name needle -print -quit

   OOPPEERRAATTOORRSS
       Listed in order of decreasing precedence:

       ( _e_x_p_r )
              Force precedence.  Since parentheses are special to  the  shell,
              you  will  normally need to quote them.  Many of the examples in
              this manual page use backslashes for this purpose: `\(...\)' in‐
              stead of `(...)'.

       ! _e_x_p_r True  if  _e_x_p_r  is false.  This character will also usually need
              protection from interpretation by the shell.

       -not _e_x_p_r
              Same as ! _e_x_p_r, but not POSIX compliant.

       _e_x_p_r_1 _e_x_p_r_2
              Two expressions in a row are taken to be joined with an  implied
              --aa; _e_x_p_r_2 is not evaluated if _e_x_p_r_1 is false.

       _e_x_p_r_1 -a _e_x_p_r_2
              Same as _e_x_p_r_1 _e_x_p_r_2.

       _e_x_p_r_1 -and _e_x_p_r_2
              Same as _e_x_p_r_1 _e_x_p_r_2, but not POSIX compliant.

       _e_x_p_r_1 -o _e_x_p_r_2
              Or; _e_x_p_r_2 is not evaluated if _e_x_p_r_1 is true.

       _e_x_p_r_1 -or _e_x_p_r_2
              Same as _e_x_p_r_1 --oo _e_x_p_r_2, but not POSIX compliant.

       _e_x_p_r_1 , _e_x_p_r_2
              List;  both  _e_x_p_r_1 and _e_x_p_r_2 are always evaluated.  The value of
              _e_x_p_r_1 is discarded; the value of the list is the value of _e_x_p_r_2.
              The  comma operator can be useful for searching for several dif‐
              ferent types of thing, but traversing the  filesystem  hierarchy
              only  once.  The --ffpprriinnttff action can be used to list the various
              matched items into several different output files.

       Please note that --aa when specified implicitly (for example by two tests
       appearing  without an explicit operator between them) or explicitly has
       higher precedence than --oo.  This means that ffiinndd .. --nnaammee aaffiillee --oo --nnaammee
       bbffiillee --pprriinntt will never print _a_f_i_l_e.

UUNNUUSSUUAALL FFIILLEENNAAMMEESS
       Many of the actions of ffiinndd result in the printing of data which is un‐
       der the control of other users.  This includes file names, sizes, modi‐
       fication  times and so forth.  File names are a potential problem since
       they can contain any character except `\0' and `/'.  Unusual characters
       in  file  names  can do unexpected and often undesirable things to your
       terminal (for example, changing the settings of your function  keys  on
       some terminals).  Unusual characters are handled differently by various
       actions, as described below.

       -print0, -fprint0
              Always print the exact filename, unchanged, even if  the  output
              is going to a terminal.

       -ls, -fls
              Unusual  characters are always escaped.  White space, backslash,
              and double quote characters are printed using  C-style  escaping
              (for  example `\f', `\"').  Other unusual characters are printed
              using an octal escape.  Other printable characters (for --llss  and
              --ffllss  these  are  the characters between octal 041 and 0176) are
              printed as-is.

       -printf, -fprintf
              If the output is not going to a terminal, it is  printed  as-is.
              Otherwise, the result depends on which directive is in use.  The
              directives %D, %F, %g, %G, %H, %Y, and %y expand to values which
              are  not  under control of files' owners, and so are printed as-
              is.  The directives %a, %b, %c, %d, %i, %k, %m, %M, %n, %s,  %t,
              %u and %U have values which are under the control of files' own‐
              ers but which cannot be used to send arbitrary data to the  ter‐
              minal,  and  so these are printed as-is.  The directives %f, %h,
              %l, %p and %P are quoted.  This quoting is performed in the same
              way  as  for  GNU llss.  This is not the same quoting mechanism as
              the one used for --llss and --ffllss.  If you are able to  decide  what
              format  to use for the output of ffiinndd then it is normally better
              to use `\0' as a terminator than to use newline, as  file  names
              can  contain white space and newline characters.  The setting of
              the LLCC__CCTTYYPPEE environment variable is  used  to  determine  which
              characters need to be quoted.

       -print, -fprint
              Quoting  is handled in the same way as for --pprriinnttff and --ffpprriinnttff.
              If you are using ffiinndd in a script or in a  situation  where  the
              matched  files  might  have arbitrary names, you should consider
              using --pprriinntt00 instead of --pprriinntt.

       The --ookk and --ookkddiirr actions print the current filename as-is.  This  may
       change in a future release.

SSTTAANNDDAARRDDSS CCOONNFFOORRMMAANNCCEE
       For  closest  compliance  to  the  POSIX  standard,  you should set the
       PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable.  The following options are speci‐
       fied in the POSIX standard (IEEE Std 1003.1-2008, 2016 Edition):

       --HH     This option is supported.

       --LL     This option is supported.

       --nnaammee  This  option  is supported, but POSIX conformance depends on the
              POSIX conformance of the system's ffnnmmaattcchh(3)  library  function.
              As  of  findutils-4.2.2,  shell metacharacters (`*', `?' or `[]'
              for example) match a leading `.', because IEEE PASC  interpreta‐
              tion 126 requires this.  This is a change from previous versions
              of findutils.

       --ttyyppee  Supported.  POSIX specifies `b', `c', `d',  `l',  `p',  `f'  and
              `s'.  GNU find also supports `D', representing a Door, where the
              OS provides these.  Furthermore, GNU find allows multiple  types
              to be specified at once in a comma-separated list.

       --ookk    Supported.   Interpretation  of the response is according to the
              `yes' and `no' patterns selected by setting the LLCC__MMEESSSSAAGGEESS  en‐
              vironment  variable.  When the PPOOSSIIXXLLYY__CCOORRRREECCTT environment vari‐
              able is set, these patterns are taken system's definition  of  a
              positive (yes) or negative (no) response.  See the system's doc‐
              umentation for nnll__llaannggiinnffoo(3), in particular YESEXPR and NOEXPR.
              When  PPOOSSIIXXLLYY__CCOORRRREECCTT is not set, the patterns are instead taken
              from ffiinndd's own message catalogue.

       --nneewweerr Supported.  If the file specified is a symbolic link, it is  al‐
              ways  dereferenced.   This  is a change from previous behaviour,
              which used to take the relevant time from the symbolic link; see
              the HISTORY section below.

       --ppeerrmm  Supported.   If  the PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable is not
              set, some mode arguments (for example +a+x) which are not  valid
              in POSIX are supported for backward-compatibility.

       Other primaries
              The  primaries  --aattiimmee,  --ccttiimmee,  --ddeepptthh, --eexxeecc, --ggrroouupp, --lliinnkkss,
              --mmttiimmee, --nnooggrroouupp, --nnoouusseerr, --ookk, --ppaatthh,  --pprriinntt,  --pprruunnee,  --ssiizzee,
              --uusseerr and --xxddeevv are all supported.

       The POSIX standard specifies parentheses `(', `)', negation `!' and the
       logical AND/OR operators --aa and --oo.

       All other options, predicates, expressions and so forth are  extensions
       beyond  the POSIX standard.  Many of these extensions are not unique to
       GNU find, however.

       The POSIX standard requires that ffiinndd detects loops:

              The ffiinndd utility shall detect infinite loops; that is,  entering
              a  previously  visited directory that is an ancestor of the last
              file encountered.  When it detects an infinite loop, find  shall
              write  a  diagnostic  message to standard error and shall either
              recover its position in the hierarchy or terminate.

       GNU ffiinndd complies with these requirements.  The link count of  directo‐
       ries which contain entries which are hard links to an ancestor will of‐
       ten be lower than they otherwise should be.  This  can  mean  that  GNU
       find  will sometimes optimise away the visiting of a subdirectory which
       is actually a link to an ancestor.  Since ffiinndd does not actually  enter
       such  a subdirectory, it is allowed to avoid emitting a diagnostic mes‐
       sage.  Although this behaviour may be somewhat  confusing,  it  is  un‐
       likely  that  anybody  actually depends on this behaviour.  If the leaf
       optimisation has been turned off with --nnoolleeaaff, the directory entry will
       always  be  examined and the diagnostic message will be issued where it
       is appropriate.  Symbolic links cannot be used to create filesystem cy‐
       cles  as  such, but if the --LL option or the --ffoollllooww option is in use, a
       diagnostic message is issued when ffiinndd encounters a  loop  of  symbolic
       links.  As with loops containing hard links, the leaf optimisation will
       often mean that ffiinndd knows that it  doesn't  need  to  call  _s_t_a_t_(_)  or
       _c_h_d_i_r_(_) on the symbolic link, so this diagnostic is frequently not nec‐
       essary.

       The --dd option is supported for compatibility with various BSD  systems,
       but you should use the POSIX-compliant option --ddeepptthh instead.

       The  PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable does not affect the behaviour
       of the --rreeggeexx or --iirreeggeexx tests because those tests aren't specified  in
       the POSIX standard.

EENNVVIIRROONNMMEENNTT VVAARRIIAABBLLEESS
       LANG   Provides  a default value for the internationalization variables
              that are unset or null.

       LC_ALL If set to a non-empty string value, override the values  of  all
              the other internationalization variables.

       LC_COLLATE
              The POSIX standard specifies that this variable affects the pat‐
              tern matching to be used for the --nnaammee option.   GNU  find  uses
              the  ffnnmmaattcchh(3)  library function, and so support for LLCC__CCOOLLLLAATTEE
              depends on the system library.  This variable also  affects  the
              interpretation  of  the  response  to --ookk; while the LLCC__MMEESSSSAAGGEESS
              variable selects the actual pattern used to  interpret  the  re‐
              sponse  to --ookk, the interpretation of any bracket expressions in
              the pattern will be affected by LLCC__CCOOLLLLAATTEE.

       LC_CTYPE
              This variable affects the treatment of character classes used in
              regular  expressions  and  also with the --nnaammee test, if the sys‐
              tem's ffnnmmaattcchh(3) library function supports this.  This  variable
              also  affects the interpretation of any character classes in the
              regular expressions used to interpret the response to the prompt
              issued  by --ookk.  The LLCC__CCTTYYPPEE environment variable will also af‐
              fect which characters are  considered  to  be  unprintable  when
              filenames are printed; see the section UNUSUAL FILENAMES.

       LC_MESSAGES
              Determines the locale to be used for internationalised messages.
              If the PPOOSSIIXXLLYY__CCOORRRREECCTT environment variable is  set,  this  also
              determines the interpretation of the response to the prompt made
              by the --ookk action.

       NLSPATH
              Determines the location of the internationalisation message cat‐
              alogues.

       PATH   Affects  the directories which are searched to find the executa‐
              bles invoked by --eexxeecc, --eexxeeccddiirr, --ookk and --ookkddiirr.

       POSIXLY_CORRECT
              Determines the block size used by --llss and --ffllss.  If PPOOSSIIXXLLYY__CCOORR‐‐
              RREECCTT  is set, blocks are units of 512 bytes.  Otherwise they are
              units of 1024 bytes.

              Setting this variable also turns off warning messages (that  is,
              implies  --nnoowwaarrnn)  by default, because POSIX requires that apart
              from the output for --ookk, all messages printed on stderr are  di‐
              agnostics and must result in a non-zero exit status.

              When PPOOSSIIXXLLYY__CCOORRRREECCTT is not set, --ppeerrmm _+_z_z_z is treated just like
              --ppeerrmm  _/_z_z_z  if  _+_z_z_z  is  not  a  valid  symbolic  mode.   When
              PPOOSSIIXXLLYY__CCOORRRREECCTT is set, such constructs are treated as an error.

              When  PPOOSSIIXXLLYY__CCOORRRREECCTT is set, the response to the prompt made by
              the --ookk action is interpreted according to the system's  message
              catalogue,  as opposed to according to ffiinndd's own message trans‐
              lations.

       TZ     Affects the time zone used for some of the  time-related  format
              directives of --pprriinnttff and --ffpprriinnttff.

EEXXAAMMPPLLEESS
   SSiimmppllee ``ffiinndd||xxaarrggss`` aapppprrooaacchh
       •      Find  files named _c_o_r_e in or below the directory _/_t_m_p and delete
              them.

                  $$ ffiinndd //ttmmpp --nnaammee ccoorree --ttyyppee ff --pprriinntt || xxaarrggss //bbiinn//rrmm --ff

              Note that this will work incorrectly if there are any  filenames
              containing newlines, single or double quotes, or spaces.

   SSaaffeerr ``ffiinndd --pprriinntt00 || xxaarrggss --00`` aapppprrooaacchh
       •      Find  files named _c_o_r_e in or below the directory _/_t_m_p and delete
              them, processing filenames in such a way that file or  directory
              names containing single or double quotes, spaces or newlines are
              correctly handled.

                  $$ ffiinndd //ttmmpp --nnaammee ccoorree --ttyyppee ff --pprriinntt00 || xxaarrggss --00 //bbiinn//rrmm --ff

              The --nnaammee test comes before the --ttyyppee test  in  order  to  avoid
              having to call ssttaatt(2) on every file.

       Note that there is still a race between the time ffiinndd traverses the hi‐
       erarchy printing the matching filenames, and the time the process  exe‐
       cuted by xxaarrggss works with that file.

   PPrroocceessssiinngg aarrbbiittrraarryy ssttaarrttiinngg ppooiinnttss
       •      Given that another program _p_r_o_g_g_y pre-filters and creates a huge
              NUL-separated list of files, process those as  starting  points,
              and find all regular, empty files among them:

                  $$ pprrooggggyy || ffiinndd --ffiilleess00--ffrroomm -- --mmaaxxddeepptthh 00 --ttyyppee ff --eemmppttyy

              The  use  of  ``--ffiilleess00--ffrroomm --``  means  to  read the names of the
              starting points from _s_t_a_n_d_a_r_d _i_n_p_u_t, i.e., from  the  pipe;  and
              --mmaaxxddeepptthh 00 ensures that only explicitly those entries are exam‐
              ined without recursing into directories (in the case one of  the
              starting points is one).

   EExxeeccuuttiinngg aa ccoommmmaanndd ffoorr eeaacchh ffiillee
       •      Run _f_i_l_e on every file in or below the current directory.

                  $$ ffiinndd .. --ttyyppee ff --eexxeecc ffiillee ''{{}}'' \\;;

              Notice  that  the  braces  are enclosed in single quote marks to
              protect them from interpretation as  shell  script  punctuation.
              The  semicolon is similarly protected by the use of a backslash,
              though single quotes could have been used in that case also.

       In many cases, one might prefer the ``--eexxeecc ...... ++`` or better  the  ``--eexx‐‐
       eeccddiirr ...... ++`` syntax for performance and security reasons.

   TTrraavveerrssiinngg tthhee ffiilleessyysstteemm jjuusstt oonnccee -- ffoorr 22 ddiiffffeerreenntt aaccttiioonnss
       •      Traverse the filesystem just once, listing set-user-ID files and
              directories   into   _/_r_o_o_t_/_s_u_i_d_._t_x_t   and   large   files   into
              _/_r_o_o_t_/_b_i_g_._t_x_t.

                  $$ ffiinndd // \\
                      \\(( --ppeerrmm --44000000 --ffpprriinnttff //rroooott//ssuuiidd..ttxxtt ''%%##mm %%uu %%pp\\nn'' \\)) ,, \\
                      \\(( --ssiizzee ++110000MM --ffpprriinnttff //rroooott//bbiigg..ttxxtt ''%%--1100ss %%pp\\nn'' \\))

              This  example  uses  the  line-continuation character '\' on the
              first two lines to instruct the shell to  continue  reading  the
              command on the next line.

   SSeeaarrcchhiinngg ffiilleess bbyy aaggee
       •      Search for files in your home directory which have been modified
              in the last twenty-four hours.

                  $$ ffiinndd $$HHOOMMEE --mmttiimmee 00

              This command works this way because the time since each file was
              last  modified  is divided by 24 hours and any remainder is dis‐
              carded.  That means that to match --mmttiimmee 00, a file will have  to
              have a modification in the past which is less than 24 hours ago.

   SSeeaarrcchhiinngg ffiilleess bbyy ppeerrmmiissssiioonnss
       •      Search for files which are executable but not readable.

                  $$ ffiinndd //ssbbiinn //uussrr//ssbbiinn --eexxeeccuuttaabbllee \\!! --rreeaaddaabbllee --pprriinntt

       •      Search  for files which have read and write permission for their
              owner, and group, but which other users can read but  not  write
              to.

                  $$ ffiinndd .. --ppeerrmm 666644

              Files  which meet these criteria but have other permissions bits
              set (for example if someone can execute the file)  will  not  be
              matched.

       •      Search  for files which have read and write permission for their
              owner and group, and which other users can read, without  regard
              to  the  presence  of any extra permission bits (for example the
              executable bit).

                  $$ ffiinndd .. --ppeerrmm --666644

              This will match a file which has mode _0_7_7_7, for example.

       •      Search for files which are writable by somebody (their owner, or
              their group, or anybody else).

                  $$ ffiinndd .. --ppeerrmm //222222

       •      Search  for  files  which  are writable by either their owner or
              their group.

                  $$ ffiinndd .. --ppeerrmm //222200
                  $$ ffiinndd .. --ppeerrmm //uu++ww,,gg++ww
                  $$ ffiinndd .. --ppeerrmm //uu==ww,,gg==ww

              All three of these commands do the same thing, but the first one
              uses  the  octal  representation of the file mode, and the other
              two use the symbolic form.  The files don't have to be  writable
              by both the owner and group to be matched; either will do.

       •      Search  for  files  which  are  writable by both their owner and
              their group.

                  $$ ffiinndd .. --ppeerrmm --222200
                  $$ ffiinndd .. --ppeerrmm --gg++ww,,uu++ww

              Both these commands do the same thing.

       •      A more elaborate search on permissions.

                  $$ ffiinndd .. --ppeerrmm --444444 --ppeerrmm //222222 \\!! --ppeerrmm //111111
                  $$ ffiinndd .. --ppeerrmm --aa++rr --ppeerrmm //aa++ww \\!! --ppeerrmm //aa++xx

              These two commands both search for files that are  readable  for
              everybody  (--ppeerrmm  --444444  or --ppeerrmm --aa++rr), have at least one write
              bit set (--ppeerrmm //222222 or --ppeerrmm //aa++ww) but are  not  executable  for
              anybody (!! --ppeerrmm //111111 or !! --ppeerrmm //aa++xx respectively).

   PPrruunniinngg -- oommiittttiinngg ffiilleess aanndd ssuubbddiirreeccttoorriieess
       •      Copy  the  contents  of _/_s_o_u_r_c_e_-_d_i_r to _/_d_e_s_t_-_d_i_r, but omit files
              and directories named _._s_n_a_p_s_h_o_t (and anything in them).  It also
              omits files or directories whose name ends in `~', but not their
              contents.

                  $$ ccdd //ssoouurrccee--ddiirr
                  $$ ffiinndd .. --nnaammee ..ssnnaappsshhoott --pprruunnee --oo \\(( \\!! --nnaammee ''**~~'' --pprriinntt00 \\)) \\
                      || ccppiioo --ppmmdd00 //ddeesstt--ddiirr

              The construct --pprruunnee --oo \\(( ...... --pprriinntt00 \\)) is quite common.   The
              idea  here  is  that the expression before --pprruunnee matches things
              which are to be pruned.  However, the --pprruunnee action  itself  re‐
              turns true, so the following --oo ensures that the right hand side
              is evaluated only for those directories which didn't get  pruned
              (the contents of the pruned directories are not even visited, so
              their contents are irrelevant).  The  expression  on  the  right
              hand  side of the --oo is in parentheses only for clarity.  It em‐
              phasises that the --pprriinntt00 action takes  place  only  for  things
              that  didn't  have  --pprruunnee applied to them.  Because the default
              `and' condition between tests binds more tightly than  --oo,  this
              is  the default anyway, but the parentheses help to show what is
              going on.

       •      Given the following directory of projects and  their  associated
              SCM  administrative directories, perform an efficient search for
              the projects' roots:

                  $$ ffiinndd rreeppoo// \\
                      \\(( --eexxeecc tteesstt --dd ''{{}}//..ssvvnn'' \\;; \\
                      --oorr --eexxeecc tteesstt --dd ''{{}}//..ggiitt'' \\;; \\
                      --oorr --eexxeecc tteesstt --dd ''{{}}//CCVVSS'' \\;; \\
                      \\)) --pprriinntt --pprruunnee

              Sample output:

                  rreeppoo//pprroojjeecctt11//CCVVSS
                  rreeppoo//ggnnuu//pprroojjeecctt22//..ssvvnn
                  rreeppoo//ggnnuu//pprroojjeecctt33//..ssvvnn
                  rreeppoo//ggnnuu//pprroojjeecctt33//ssrrcc//..ssvvnn
                  rreeppoo//pprroojjeecctt44//..ggiitt

              In this example, --pprruunnee prevents unnecessary descent into direc‐
              tories  that have already been discovered (for example we do not
              search _p_r_o_j_e_c_t_3_/_s_r_c because we already found _p_r_o_j_e_c_t_3_/_._s_v_n), but
              ensures sibling directories (_p_r_o_j_e_c_t_2 and _p_r_o_j_e_c_t_3) are found.

   OOtthheerr uusseeffuull eexxaammpplleess
       •      Search for several file types.

                  $$ ffiinndd //ttmmpp --ttyyppee ff,,dd,,ll

              Search  for files, directories, and symbolic links in the direc‐
              tory _/_t_m_p passing these types as a comma-separated list (GNU ex‐
              tension),  which is otherwise equivalent to the longer, yet more
              portable:

                  $$ ffiinndd //ttmmpp \\(( --ttyyppee ff --oo --ttyyppee dd --oo --ttyyppee ll \\))

       •      Search for files with the particular name _n_e_e_d_l_e and stop  imme‐
              diately when we find the first one.

                  $$ ffiinndd // --nnaammee nneeeeddllee --pprriinntt --qquuiitt

       •      Demonstrate  the  interpretation  of the %%ff and %%hh format direc‐
              tives of the --pprriinnttff action for some corner-cases.  Here  is  an
              example including some output.

                  $$ ffiinndd .. .... // //ttmmpp //ttmmpp//TTRRAACCEE ccoommppiillee ccoommppiillee//6644//tteessttss//ffiinndd --mmaaxxddeepptthh 00 --pprriinnttff ''[[%%hh]][[%%ff]]\\nn''
                  [[..]][[..]]
                  [[..]][[....]]
                  [[]][[//]]
                  [[]][[ttmmpp]]
                  [[//ttmmpp]][[TTRRAACCEE]]
                  [[..]][[ccoommppiillee]]
                  [[ccoommppiillee//6644//tteessttss]][[ffiinndd]]

EEXXIITT SSTTAATTUUSS
       ffiinndd  exits  with  status  0  if  all files are processed successfully,
       greater than 0 if errors occur.  This is deliberately a very broad  de‐
       scription,  but if the return value is non-zero, you should not rely on
       the correctness of the results of ffiinndd.

       When some error occurs, ffiinndd may stop immediately,  without  completing
       all  the  actions specified.  For example, some starting points may not
       have  been  examined  or   some   pending   program   invocations   for
       --eexxeecc ...... {{}} ++ or --eexxeeccddiirr ...... {{}} ++ may not have been performed.

HHIISSTTOORRYY
       As of findutils-4.2.2, shell metacharacters (`*', `?' or `[]' for exam‐
       ple) used in filename patterns match a leading `.', because IEEE  POSIX
       interpretation 126 requires this.

       As  of  findutils-4.3.3,  --ppeerrmm //000000  now  matches all files instead of
       none.

       Nanosecond-resolution timestamps were implemented in findutils-4.3.3.

       As of findutils-4.3.11, the --ddeelleettee action sets ffiinndd's exit status to a
       nonzero  value when it fails.  However, ffiinndd will not exit immediately.
       Previously, ffiinndd's  exit  status  was  unaffected  by  the  failure  of
       --ddeelleettee.

       Feature                Added in   Also occurs in
       -files0-from           4.9.0
       -newerXY               4.3.3      BSD
       -D                     4.3.1
       -O                     4.3.1
       -readable              4.3.0
       -writable              4.3.0
       -executable            4.3.0
       -regextype             4.2.24
       -exec ... +            4.2.12     POSIX
       -execdir               4.2.12     BSD
       -okdir                 4.2.12
       -samefile              4.2.11
       -H                     4.2.5      POSIX
       -L                     4.2.5      POSIX
       -P                     4.2.5      BSD
       -delete                4.2.3
       -quit                  4.2.3

       -d                     4.2.3      BSD
       -wholename             4.2.0
       -iwholename            4.2.0
       -ignore_readdir_race   4.2.0
       -fls                   4.0
       -ilname                3.8
       -iname                 3.8
       -ipath                 3.8
       -iregex                3.8

       The  syntax  --ppeerrmm  ++MMOODDEE was removed in findutils-4.5.12, in favour of
       --ppeerrmm //MMOODDEE.   The  ++MMOODDEE  syntax  had  been  deprecated  since  findu‐
       tils-4.2.21 which was released in 2005.

NNOONN--BBUUGGSS
   OOppeerraattoorr pprreecceeddeennccee ssuurrpprriisseess
       The  command  ffiinndd .. --nnaammee aaffiillee --oo --nnaammee bbffiillee --pprriinntt will never print
       _a_f_i_l_e because this is actually equivalent to ffiinndd .. --nnaammee aaffiillee  --oo  \\((
       --nnaammee bbffiillee --aa --pprriinntt \\)).  Remember that the precedence of --aa is higher
       than that of --oo and when there is no operator specified between  tests,
       --aa is assumed.

   ““ppaatthhss mmuusstt pprreecceeddee eexxpprreessssiioonn”” eerrrroorr mmeessssaaggee
       $$ ffiinndd .. --nnaammee **..cc --pprriinntt
       find: paths must precede expression
       find: possible unquoted pattern after predicate `-name'?

       This  happens  when the shell could expand the pattern _*_._c to more than
       one file name existing in the current directory, and  passing  the  re‐
       sulting file names in the command line to ffiinndd like this:
       ffiinndd .. --nnaammee ffrrccooddee..cc llooccaattee..cc wwoorrdd__iioo..cc --pprriinntt
       That  command  is of course not going to work, because the --nnaammee predi‐
       cate allows exactly only one pattern as  argument.   Instead  of  doing
       things this way, you should enclose the pattern in quotes or escape the
       wildcard, thus allowing ffiinndd to use the pattern with the wildcard  dur‐
       ing the search for file name matching instead of file names expanded by
       the parent shell:
       $$ ffiinndd .. --nnaammee ''**..cc'' --pprriinntt
       $$ ffiinndd .. --nnaammee \\**..cc --pprriinntt

BBUUGGSS
       There are security problems inherent in the behaviour  that  the  POSIX
       standard  specifies for ffiinndd, which therefore cannot be fixed.  For ex‐
       ample, the --eexxeecc action is inherently insecure, and --eexxeeccddiirr should  be
       used instead.

       The environment variable LLCC__CCOOLLLLAATTEE has no effect on the --ookk action.

RREEPPOORRTTIINNGG BBUUGGSS
       GNU   findutils   online   help:   <https://www.gnu.org/software/findu‐
       tils/#get-help>
       Report any translation bugs to <https://translationproject.org/team/>

       Report any other issue via the form at the GNU Savannah bug tracker:
              <https://savannah.gnu.org/bugs/?group=findutils>
       General topics about the GNU findutils package  are  discussed  at  the
       _b_u_g_-_f_i_n_d_u_t_i_l_s mailing list:
              <https://lists.gnu.org/mailman/listinfo/bug-findutils>

CCOOPPYYRRIIGGHHTT
       Copyright  ©  1990-2022 Free Software Foundation, Inc.  License GPLv3+:
       GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
       This is free software: you are free  to  change  and  redistribute  it.
       There is NO WARRANTY, to the extent permitted by law.

SSEEEE AALLSSOO
       cchhmmoodd(1),  llooccaattee(1),  llss(1), uuppddaatteeddbb(1), xxaarrggss(1), llssttaatt(2), ssttaatt(2),
       ccttiimmee(3) ffnnmmaattcchh(3), pprriinnttff(3), ssttrrffttiimmee(3), llooccaatteeddbb(5), rreeggeexx(7)

       Full documentation <https://www.gnu.org/software/findutils/find>
       or available locally via: iinnffoo ffiinndd

                                                                       FIND(1)
