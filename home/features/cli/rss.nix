{ config, lib, ... }:

with lib;
let cfg = config.features.cli.rss;
in {
  options.features.cli.rss.enable =
    mkEnableOption "Enable newsboat CLI rss reader";

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      urls = [
        {
          url = "https://www.redhat.com/en/rss/blog";
          tags = [ "linux" ];
        }
        {
          url = "https://lwn.net/headlines/newrss";
          tags = [ "linux" ];
        }
        {
          url = "https://itsfoss.com/rss/";
          tags = [ "linux" "foss" ];
        }
        {
          url = "https://www.bleepingcomputer.com/feed/";
          tags = [ "security" ];
        }
        {
          url = "https://news.ycombinator.com/rss";
          tags = [ "security" "hackernews" ];
        }
        {
          url = "https://www.docker.com/feed/";
          tags = [ "docker" "containers" ];
        }
        {
          url = "https://kubernetes.io/feed.xml";
          tags = [ "kuberentes" "containers" ];
        }
        {
          url = "https://www.cncf.io/feed";
          tags = [ "kubernetes" "containers" "cncf" ];
        }
        {
          url = "https://www.devopsbulletin.com/feed";
          tags = [ "devops" ];
        }
        {
          url = "https://www.lastweekinaws.com/feed/";
          tags = [ "cloud" "aws" ];
        }
        {
          url = "https://github.blog/feed/";
          tags = [ "blog" "development" "github" ];
        }
      ];
    };
  };
}
