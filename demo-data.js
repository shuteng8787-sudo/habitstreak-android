// HabitStreak Demo Data - Run this in browser console at https://shuteng8787-sudo.github.io/habitstreak/
// Then refresh page to see beautiful demo state for screenshots

const demoData = {
    lang: 'en',
    habits: [
        {
            id: 'h1',
            name: 'Read 20 pages',
            color: '#059669',
            checks: generateChecks(45, [0,1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31,32,35,36,37,38,39,42,43,44])
        },
        {
            id: 'h2',
            name: 'Morning Meditation',
            color: '#7C3AED',
            checks: generateChecks(30, [0,1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,23,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44])
        },
        {
            id: 'h3',
            name: 'Daily Workout',
            color: '#2563EB',
            checks: generateChecks(28, [0,1,3,4,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,22,24,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44])
        },
        {
            id: 'h4',
            name: 'Drink 2L Water',
            color: '#0D9488',
            checks: generateChecks(38, [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44])
        }
    ]
};

function generateChecks(totalDays, activeIndices) {
    const checks = {};
    const today = new Date();
    for (let i = 0; i < totalDays; i++) {
        const d = new Date(today);
        d.setDate(d.getDate() - i);
        const key = `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
        if (activeIndices.includes(i)) {
            checks[key] = true;
        }
    }
    return checks;
}

localStorage.setItem('habitstreak_data', JSON.stringify(demoData));
console.log('Demo data injected! Refresh page to see it.');
console.log('Expected streaks: Read=12, Meditation=8, Workout=5, Water=38');
