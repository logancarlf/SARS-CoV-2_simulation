# differential equations to solve
def differentials(y, t, N, beta, gamma, mu, v, tvac):
    S, I, R, D, V = y
    if t >= tvac:
        dS_dt = -beta * S * I / N - v * S
        dV_dt = v * S
    else:
        dS_dt = -beta * S * I / N
        dV_dt = 0
    dI_dt = beta * S * I / N - gamma * I - mu * I
    dR_dt = gamma * I
    dD_dt = mu * I
    return dS_dt, dI_dt, dR_dt, dD_dt, dV_dt
