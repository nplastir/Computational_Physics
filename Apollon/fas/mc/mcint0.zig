const std = @import("std");
const print = std.debug.print;
const math = std.math;

fn sq(x: f64) f64 {
    return math.pow(f64, x, 2);
}

fn ln(x: f64) f64 {
    return math.log(f64, math.e, x);
}

var _rand = std.rand.DefaultPrng.init(17179);

fn unif() f64 {
    return _rand.random().float(f64);
}

const r64 = struct {
    val: f64,
    err: f64,

    fn println(self: *r64) void {
        print("{d} +/- {d}\n", self.*);
    }
};

fn integrateCrude(
    a: f64, b: f64, comptime f: *const fn (f64) f64, N: usize
) r64 {
    var sum: f64 = 0;
    var sum2: f64 = 0;
    const volume = b - a;
    const Nf = @intToFloat(f64, N);

    for (0..N) |_| {
        var y = f(unif() * volume + a);

        sum += y;
        sum2 += sq(y);
    }

    sum /= Nf; sum2 /= Nf;

    return r64{ 
        .val = volume * sum,
        .err = volume * math.sqrt((sum2 - sq(sum)) / Nf)
    };
}


fn integrateStratified(
    comptime Ni: usize, xs: [Ni+1]f64, 
    comptime f: *const fn (f64) f64, N: usize
) r64 {
    var result = r64{ .val = 0, .err = 0 };
    // var sum2: f64 = 0;
    // const Nif = @intToFloat(f64, Ni);

    for (0..(xs.len - 1)) |i| {
        var r = integrateCrude(xs[i], xs[i+1], f, N);

        // r.println();

        result.val += r.val;
        // sum2 += sq(r.val);
        result.err += sq(r.err);
        // result.err += r.err;
    }

    result.err = math.sqrt(result.err);

    return result;
}


fn partition(a: f64, b: f64, comptime N: usize) [N+1]f64 {
    var result: [N+1]f64 = undefined;

    const step = (b - a) / @intToFloat(f64, N);

    for (0..(N+1)) |i| {
        result[i] = a + step * @intToFloat(f64, i);
    }

    return result;
}


fn f0(x: f64) f64 {
    return math.exp(-sq(x));
}

const alpha: f64 = 1.0 / (1.0 - math.exp(-1.0));

fn g0(x: f64) f64 {
    return alpha * math.exp(-x);
}
fn G0(x: f64) f64 {
    return alpha * (1 - math.exp(-x));
}
fn Ginv0(x: f64) f64 {
    return - math.ln(1 - x / alpha);
}
fn f1(y: f64) f64 {
    var x = Ginv0(y);
    return f0(x) / g0(x);
}

pub fn main() !void {
    const Ns = comptime [3]usize{ 100, 1000, 10000 };

    print("flat sampling\n", .{});
    const a: f64 = 0; const b: f64 = 1;

    for (Ns) |N| {
        var r = integrateCrude(a, b, f0, N);
        r.println();
    }

    print("\nimportance sampling\n", .{});
    const A = comptime G0(a); const B = comptime G0(b);

    for (Ns) |N| {
        var r = integrateCrude(A, B, f1, N);
        r.println();
    }

    print("\nstratification\n", .{});
    comptime var Ni = 1;

    inline while (Ni < 10) : (Ni *= 2) {
        var r = integrateStratified(Ni, partition(a, b, Ni), f0, 10000);
        // print("-----", .{});
        r.println();
    }
    // var r = integrateStratified(2, partition(a, b, 2), f0, 500);
    // r.println();
    // r = integrateStratified(4, partition(a, b, 4), f0, 250);
    // r.println();

    // print("\nother\n", .{});
    // r = integrateCrude(0.0, 0.5, f0, 500);
    // r.println();
    // r = integrateCrude(0.5, 1.0, f0, 500);
    // r.println();

    // print("\nother\n", .{});
    // r = integrateCrude(0.0, 0.25, f0, 250);
    // r.println();
    // r = integrateCrude(0.25, 0.5, f0, 250);
    // r.println();
    // r = integrateCrude(0.5, 0.75, f0, 250);
    // r.println();
    // r = integrateCrude(0.75, 1.0, f0, 250);
    // r.println();
}
