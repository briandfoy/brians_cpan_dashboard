#!/Users/brian/bin/perl
use v5.26;
use experimental qw(signatures);

use lib qw(/Users/brian/Dev/ghojo/lib);

use Mojo::Template;
use Mojo::Util qw(dumper);

my $user = $ARGV[0] // 'briandfoy';

my @repos = get_repos($user);

print <<'HTML';
<html>
<head>
	<title>brian's Perl module status</title>
	<meta http-equiv="refresh" content="300">
</head>

<body>
<p>As of <span id='date-time'></span>.</p>
<script>
var dt = new Date();
document.getElementById('date-time').innerHTML=dt;
</script>
<style>
a.repo {
	font-face: sans-serif;
	}
</style>

<table>
	<tr>
		<th id="macos">macOS</th>
		<th id="ubuntu">Ubuntu</th>
		<th id="windows">Windows</th>
		<th id="appveyor">AppVeyor</th>
		<th id="coverage">Coverage</th>
		<th id="repo">repo</th>
	</tr>
HTML

foreach my $repo ( @repos ) {
	print <<~"HTML";
	<tr id="$repo">
		<td><a class="github macos"   href="https://www.github.com/$repo/actions?query=workflow%3Amacos"   ><img alt="<missing>" onerror="this.style.display='none'" src="https://www.github.com/$repo/workflows/macos/badge.svg"                                /></a></td>
		<td><a class="github ubuntu"  href="https://www.github.com/$repo/actions?query=workflow%3Aubuntu"  ><img alt="<missing>" onerror="this.style.display='none'" src="https://www.github.com/$repo/workflows/ubuntu/badge.svg"                               /></a></td>
		<td><a class="github windows" href="https://www.github.com/$repo/actions?query=workflow%3Awindows" ><img alt="<missing>" onerror="this.style.display='none'" src="https://www.github.com/$repo/workflows/windows/badge.svg"                              /></a></td>
		<td><a class="appveyor"       href="https://ci.appveyor.com/project/$repo"                         ><img alt="<missing>" onerror="this.style.display='none'" src="https://ci.appveyor.com/api/projects/status/github/$repo?svg=true"                     /></a></td>
		<td><a class="coveralls"      href="https://coveralls.io/github/$repo?branch=master"               ><img alt="<missing>" onerror="this.style.display='none'" src="https://coveralls.io/repos/github/$repo/badge.svg?branch=master" alt='Coverage Status' /></a></td>
		<td><a class="github repo"    href="https://www.github.com/$repo">$repo</a></td>
	</tr>
	HTML
	}

print <<'HTML';
</table>
</body>
</html>
HTML

sub get_repos ($user) {
	state @repos = do {
		my @r = sort <<>>; chomp(@r); grep { ! not_module($_) } @r
		};

	@repos;
	}

sub get_template () {
	<<"TEMPLATE";
<html>
<head>
</head>
<body>

</body>
</html>
TEMPLATE
	}

sub not_module ($repo) {

	}

__END__
