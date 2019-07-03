load("assert.star", "assert")

p = provider("aws", "2.13.0")
d = p.data.ami("foo")

assert.eq(type(d.filter), "collection")

bar = d.filter(name="bar", values=["qux"])

assert.eq(type(bar), "resource")
assert.eq(bar.name, "bar")
assert.eq(bar.values, ["qux"])

assert.eq(len(d.filter), 1)
assert.eq(d.filter[0], bar)

qux = d.filter()
qux.name = "qux"
qux.values = ["bar"]

assert.eq(qux.name, "qux")
assert.eq(qux.values, ["bar"])

assert.eq(len(d.filter), 2)
assert.eq(d.filter[1], qux)

d.filter[1].values = ["baz"]
assert.eq(qux.values, ["baz"])

assert.ne(d.filter[0], d.filter[1])