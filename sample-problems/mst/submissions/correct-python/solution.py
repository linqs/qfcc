import sys

def main():
    # {node: {node: cost, ...}, ...}
    # Reverse edges will be added.
    edges = {}
    for line in sys.stdin:
        line = line.strip()
        if (len(line) == 0):
            continue

        parts = line.split("\t")

        nodeA = parts[0]
        weight = int(parts[1])
        nodeB = parts[2]

        for (first, second) in [(nodeA, nodeB), (nodeB, nodeA)]:
            if (first not in edges):
                edges[first] = {}

            current_cost = edges[first].get(second, None)
            if ((current_cost is None) or (weight < current_cost)):
                edges[first][second] = weight

    mst_cost = 0
    mst_nodes = set()
    remaining_nodes = set(edges.keys())

    # Seed the first node.
    if (len(remaining_nodes) > 0):
        current_node = list(remaining_nodes)[0]

        mst_nodes.add(current_node)
        remaining_nodes.remove(current_node)

    while (len(remaining_nodes) > 0):
        min_cost = None
        min_target = None

        # Check for edges to a node we have not seen yet.
        for mst_node in mst_nodes:
            for (target, cost) in edges[mst_node].items():
                if (target in mst_nodes):
                    continue

                if ((min_cost is None) or (cost < min_cost)):
                    min_cost = cost
                    min_target = target

        if (min_cost is None):
            raise ValueError("Could not find min cost node.")

        mst_cost += min_cost
        mst_nodes.add(min_target)
        remaining_nodes.remove(min_target)

    print(mst_cost)

if (__name__ == '__main__'):
    main()
