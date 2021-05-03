import yaml
from yaml import dump
try:
    from yaml import CDumper as Dumper
except ImportError:
    from yaml import Dumper
import copy
from collections import OrderedDict


DOCKER_COMPOSE_YAML = OrderedDict({
    "version": "3",
    "services": {
        "cluster-starter": {
            "image": "cluster-starter",
            "container_name": "cluster-starter",
            "networks": {
                "hadoop.net": None
            }
        }
    },
    "networks": {
        "hadoop.net": None
    }
})

yaml.add_representer(type(None), lambda dumper, value: dumper.represent_scalar(u'tag:yaml.org,2002:null', ''),
                     Dumper=Dumper)
yaml.add_representer(OrderedDict, lambda self, data:  self.represent_mapping('tag:yaml.org,2002:map', data.items()),
                     Dumper=Dumper)


def generate_yaml(data):
    compose_yaml = copy.deepcopy(DOCKER_COMPOSE_YAML)
    for name, instance in data["instances"].items():
        instance_conf = {
            "image": "local-" + instance["image"],
            "container_name": name,
            "networks": {
                "hadoop.net": None
            },
            "tty": True
        }
        if "ports" in instance and instance["ports"]:
            instance_conf["ports"] = instance["ports"]
        if "hosts" in instance and instance["hosts"]:
            instance_conf["networks"]["hadoop.net"] = { "aliases": instance["hosts"] }
            zookeeper = list(filter(lambda h: "zookeeper" in h, instance["hosts"]))
            if zookeeper:
                node_id = zookeeper[0][len("zookeeper"):]
                instance_conf["environment"] = {
                    "MY_NODE_NUM": node_id
                }
        compose_yaml["services"][name] = instance_conf
    return dump(compose_yaml, Dumper=Dumper)
